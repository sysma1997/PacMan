extends Object

class_name Enemy


var random: RandomNumberGenerator

func _init():
	random = RandomNumberGenerator.new()

func set_random_direction(before_direction: Vector2) -> Vector2:
	var next_direction = Vector2()
	
	random.randomize()
	var direction: int = random.randi_range(1, 2)
	
	if before_direction.x != 0:
		if direction == 1:
			next_direction.y -= 1
		else:
			next_direction.y += 1
	elif before_direction.y != 0:
		if direction == 1:
			next_direction.x -= 1
		else:
			next_direction.x += 1
	
	return next_direction

func set_animation_direction(direction: Vector2, animations: AnimatedSprite, is_weak: bool, is_recuperation: bool):
	if is_weak:
		if is_recuperation:
			animations.play("Recuperation")
			return
		
		animations.play("Weak")
		return
		
	if direction.x > 1:
		animations.play("Right")
	if direction.x < -1:
		animations.play("Left")
	if direction.y > 1:
		animations.play("Down")
	if direction.y < -1:
		animations.play("Up")
