extends KinematicBody2D

export var speed: int = 8000

var direction = Vector2()
var before_direction = Vector2()
var next_direction = Vector2()

func _ready():
	next_direction = Vector2(1, 0)

func _physics_process(delta):
	direction = move_and_slide(next_direction * delta)
	set_animation_direction(direction)
	
	if direction.length() > 0:
		before_direction = next_direction
		return
	
	direction = move_and_slide(before_direction * delta)
	
	if direction.length() == 0 and $Animations.playing:
		$Animations.stop()

func set_animation_direction(direction):
	if direction.x > 1:
		$Animations.play("Right")
	if direction.x < -1:
		$Animations.play("Left")
	if direction.y > 1:
		$Animations.play("Down")
	if direction.y < -1:
		$Animations.play("Up")
