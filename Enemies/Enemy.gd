extends Object

class_name Enemy

func _init():
	pass

func set_animation_direction(direction: Vector2, animations: AnimatedSprite):
	if direction.x > 1:
		animations.play("Right")
	if direction.x < -1:
		animations.play("Left")
	if direction.y > 1:
		animations.play("Down")
	if direction.y < -1:
		animations.play("Up")
