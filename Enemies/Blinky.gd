extends KinematicBody2D

const Enemy = preload("res://Enemies/Enemy.gd")
var enemy: Enemy

export var speed: int = 8000

var direction = Vector2()
var before_direction = Vector2()
var next_direction = Vector2()

var seconds: float = 0

var is_weak: bool = false
var seconds_weak: float = 0
var is_recuperation: bool = false
var is_dead: bool = false
var is_no_move: int = 0

func _ready():
	enemy = Enemy.new()
	
	next_direction = Vector2(-1, 0)
	
	Global.connect("Weaken_ghosts", self, "_on_Weaken_ghosts")
	Global.connect("Dead_ghost", self, "_on_Dead_ghost")

func _physics_process(delta):
	next_direction = next_direction.normalized() * speed
	direction = move_and_slide(next_direction * delta)
	if direction.length() == 0:
		direction = move_and_slide(before_direction * delta)
	enemy.set_animation_direction(direction, $Animations, is_weak, is_recuperation, is_dead)
	
	seconds += delta
	if seconds > 1:
		seconds = 0
		change_direction()
	
	if is_weak:
		seconds_weak += delta
		if seconds_weak > 7:
			is_recuperation = true
		if seconds_weak > 10:
			speed = 8000
			is_weak = false
			seconds_weak = 0
			is_recuperation = false
	
	if direction.length() == 0:
		is_no_move += 1
		
		var is_random = false
		if is_no_move > 3:
			is_random = true
		change_direction(is_random)
	else: 
		is_no_move = 0

func change_direction(is_random: bool = false):
	before_direction = next_direction
	next_direction = enemy.set_random_direction(before_direction, is_dead, position, is_random)
	
	if is_dead and (position.x > 176 and position.x < 272) and (position.y > 272 and position.y < 320):
		speed = 8000
		is_weak = false
		seconds_weak = 0
		is_recuperation = false
		
		is_dead = false
		next_direction = Vector2(0, -1)

func _on_Weaken_ghosts():
	if is_dead:
		return
	
	speed = 5000
	is_weak = true

func _on_Dead_ghost(name: String):
	if name == "Blinky":
		is_dead = true
		speed = 12000
		
		is_weak = false
		seconds_weak = 0
		is_recuperation = false
