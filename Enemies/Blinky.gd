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

func _ready():
	enemy = Enemy.new()
	
	next_direction = Vector2(-1, 0)
	
	Global.connect("Weaken_ghosts", self, "_on_Weaken_ghosts")

func _physics_process(delta):
	next_direction = next_direction.normalized() * speed
	direction = move_and_slide(next_direction * delta)
	if direction.length() == 0:
		direction = move_and_slide(before_direction * delta)
	enemy.set_animation_direction(direction, $Animations, is_weak, is_recuperation)
	
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
		change_direction()

func change_direction():
	before_direction = next_direction
	next_direction = enemy.set_random_direction(before_direction)

func _on_Weaken_ghosts():
	speed = 5000
	is_weak = true
