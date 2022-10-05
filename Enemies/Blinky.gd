extends KinematicBody2D

const Enemy = preload("res://Enemies/Enemy.gd")
var enemy: Enemy

export var speed: int = 8000

var direction = Vector2()
var before_direction = Vector2()
var next_direction = Vector2()

func _ready():
	enemy = Enemy.new()
	
	next_direction = Vector2(-1, 0)
	next_direction = next_direction.normalized() * speed

func _physics_process(delta):
	direction = move_and_slide(next_direction * delta)
	enemy.set_animation_direction(direction, $Animations)
	
	if direction.length() == 0:
		before_direction = next_direction
		change_direction()

func change_direction():
	print("last direction: ", enemy.to_direction(next_direction))
	print("before direction: ", enemy.to_direction(before_direction))
	next_direction = enemy.set_random_direction(speed)
	print("next direction: ", enemy.to_direction(next_direction))
	
	if enemy.is_opposite_direction(next_direction, before_direction):
		print("is opposite")
		print("")
		change_direction()
		return
	
	print("")
