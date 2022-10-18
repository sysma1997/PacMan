extends Node2D

var points: int = 0

var blinky_out: bool = false
var clyde_out: bool = false
var inky_out: bool = false
var pinky_out: bool = false
var ghosts_out: int = 1

var reset_game: bool = false
var seconds_reset: float = 0

func _ready():
	$AreaDor/Dor/Collision.set_deferred("disabled", true)
	
	Global.connect("Points", self, "_on_Points")
	Global.connect("Dead_ghost", self, "_on_Dead_ghost")

func _process(delta):
	if !reset_game:
		return
	
	seconds_reset += delta
	if seconds_reset > 3:
		get_tree().reload_current_scene()

func _on_AreaDor_body_exited(body: Node):
	if body.name == "TileMap":
		return
	
	if body.name == "Blinky":
		if blinky_out:
			ghosts_out += 1
			blinky_out = true
	if body.name == "Clyde":
		if !clyde_out:
			ghosts_out += 1
			clyde_out = true
	elif body.name == "Inky":
		if !inky_out:
			ghosts_out += 1
			inky_out = true
	elif body.name == "Pinky":
		if !pinky_out:
			ghosts_out += 1
			pinky_out = true
	
	if ghosts_out == 4:
		$AreaDor/Dor/Collision.set_deferred("disabled", false)

func _on_ExitLeft_body_entered(body: Node):
	if body.name == "TileMap":
		return
	
	body.position = Vector2(433, 296)

func _on_ExitRight_body_entered(body: Node):
	if body.name == "TileMap":
		return
	
	body.position = Vector2(15, 296)

func _on_Player_dead():
	$Blinky.visible = false
	$Clyde.visible = false
	$Inky.visible = false
	$Pinky.visible = false
	
	reset_game = true

func _on_Points(value: int):
	points += value
	$Interface/Points.text = String(points)

func _on_Dead_ghost(name: String):
	$AreaDor/Dor/Collision.set_deferred("disabled", true)
	
	if name == "Blinky":
		ghosts_out -= 1
		blinky_out = false
	elif name == "Clyde":
		ghosts_out -= 1
		clyde_out = false
	elif name == "Inky":
		ghosts_out -= 1
		inky_out = false
	elif name == "Pinky":
		ghosts_out -= 1
		pinky_out = false
