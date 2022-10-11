extends KinematicBody2D

const Enemy = preload("res://Enemies/Enemy.gd")
var enemy: Enemy

export var speed: int = 8000

var direction = Vector2()
var before_direction = Vector2()
var next_direction = Vector2()

var seconds: float = 0

func _ready():
	enemy = Enemy.new()
	
	next_direction = Vector2(-1, 0)
	next_direction = next_direction.normalized() * speed
	
	Global.connect("Weaken_ghosts", self, "_on_Weaken_ghosts")

func _physics_process(delta):
	direction = move_and_slide(next_direction * delta)
	if direction.length() == 0:
		direction = move_and_slide(before_direction * delta)
	enemy.set_animation_direction(direction, $Animations)
	
	seconds += delta
	if seconds > 1:
		seconds = 0
		change_direction()
	
	if direction.length() == 0:
		change_direction()

func change_direction():
	before_direction = next_direction
	next_direction = enemy.set_random_direction(speed, before_direction)

func _on_Weaken_ghosts():
	speed = 5000
