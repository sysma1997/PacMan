extends KinematicBody2D

signal dead

export var speed: int = 8000

var direction = Vector2()
var before_direction = Vector2()
var next_direction = Vector2()
var is_dead: bool = false

func _ready():
	next_direction = Vector2(1, 0)
	next_direction = next_direction.normalized() * speed

func _physics_process(delta):
	if is_dead:
		return
	
	get_input()
	direction = move_and_slide(next_direction * delta)
	set_rotate()
	
	if direction.length() > 0:
		before_direction = next_direction
		
		$Animations.play("Run")
		return
	
	direction = move_and_slide(before_direction * delta)
	
	if direction.length() == 0 and $Animations.playing:
		$Animations.stop()

func _on_AreaCollision_body_entered(body: Node):
	if body.name == "Player" or body.name == "TileMap":
		return
	
	is_dead = true
	emit_signal("dead")
	$Animations.play("Dead")

func get_input(): 
	if Input.is_action_just_pressed("ui_up"):
		next_direction = Vector2()
		next_direction.y -= 1
	if Input.is_action_just_pressed("ui_right"):
		next_direction = Vector2()
		next_direction.x += 1
	if Input.is_action_just_pressed("ui_down"):
		next_direction = Vector2()
		next_direction.y += 1
	if Input.is_action_just_pressed("ui_left"):
		next_direction = Vector2()
		next_direction.x -= 1
	
	if next_direction.length() > 0:
		next_direction = next_direction.normalized() * speed
func set_rotate():
	if direction.x > 1:
		$Animations.rotation_degrees = 0
	if direction.x < -1:
		$Animations.rotation_degrees = 180
	if direction.y > 1:
		$Animations.rotation_degrees = 90
	if direction.y < -1:
		$Animations.rotation_degrees = -90
