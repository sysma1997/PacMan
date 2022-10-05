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

func set_random_direction(before_direction: Vector2, speed: int) -> Vector2:
	var next_direction = Vector2()
	
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

func set_animation_direction(direction: Vector2, animations: AnimatedSprite):
	if direction.x > 1:
		animations.play("Right")
	if direction.x < -1:
		animations.play("Left")
	if direction.y > 1:
		animations.play("Down")
	if direction.y < -1:
		animations.play("Up")
