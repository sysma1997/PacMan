extends KinematicBody2D

const Enemy = preload("res://Enemies/Enemy.gd")
var enemy: Enemy

export var speed: int = 8000

var direction = Vector2()
var before_direction = Vector2()
var next_direction = Vector2()

var random: RandomNumberGenerator

func _ready():
	enemy = Enemy.new()
	random = RandomNumberGenerator.new()
	
	next_direction = Vector2(-1, 0)
	next_direction = next_direction.normalized() * speed

func _physics_process(delta):
	direction = move_and_slide(next_direction * delta)
	enemy.set_animation_direction(direction, $Animations)
	
	if direction.length() == 0:
		before_direction = next_direction
		direction_enemy_is_opposite()

func direction_enemy_is_opposite():
	next_direction = enemy.set_random_direction(speed)
	
	if enemy.is_opposite_direction(next_direction, before_direction):
		direction_enemy_is_opposite()
