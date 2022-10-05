extends Object

class_name Enemy

enum Direction {
	UP = 1, 
	RIGHT = 2, 
	DOWN = 3
	LEFT = 4,
}

var random: RandomNumberGenerator

func _init():
	random = RandomNumberGenerator.new()

func set_random_direction(speed: int) -> Vector2:
	var next_direction = Vector2()
	
	random.randomize()
	var direction: int = random.randi_range(1, 4)
	match direction:
		Direction.UP:
			next_direction.y -= 1
		Direction.RIGHT:
			next_direction.x += 1
		Direction.DOWN:
			next_direction.y += 1
		Direction.LEFT:
			next_direction.x -= 1
	
	return next_direction.normalized() * speed

func is_opposite_direction(next_direction: Vector2, before_direction: Vector2) -> bool:
	var is_opposite: bool = false
	
	if next_direction.y < -1 and before_direction.y > 1:
		is_opposite = true
	if next_direction.y > 1 and before_direction.y < -1:
		is_opposite = true
	if next_direction.x < -1 and before_direction.x > 1:
		is_opposite = true
	if next_direction.x > 1 and before_direction.x < -1:
		is_opposite = true
	
	return is_opposite

func set_animation_direction(direction: Vector2, animations: AnimatedSprite):
	if direction.x > 1:
		animations.play("Right")
	if direction.x < -1:
		animations.play("Left")
	if direction.y > 1:
		animations.play("Down")
	if direction.y < -1:
		animations.play("Up")

func to_direction(direction: Vector2) -> String :
	var direc: String = ""
	if direction.x > 1:
		direc = "Right"
	if direction.x < -1:
		direc = "Left"
	if direction.y > 1:
		direc = "Down"
	if direction.y < -1:
		direc = "Up"
	
	return direc
