extends KinematicBody2D

const Enemy = preload("res://Enemies/Enemy.gd")
var enemy: Enemy

export var speed: int = 8000

var direction = Vector2()
var before_direction = Vector2()
var next_direction = Vector2()

func _ready():
	enemy = Enemy.new()
	
	next_direction = Vector2(1, 0)
	next_direction = next_direction.normalized() * speed

func _physics_process(delta):
	direction = move_and_slide(next_direction * delta)
	enemy.set_animation_direction(direction, $Animations)
