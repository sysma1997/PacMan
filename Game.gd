extends Node2D

var points: int = 0

var clyde_out: bool = false
var inky_out: bool = false
var pinky_out: bool = false
var ghosts_out: int = 0

func _ready():
	$AreaDor/Dor/Collision.set_deferred("disabled", true)
	Global.connect("Points", self, "_on_Points")

func _on_AreaDor_body_exited(body: Node):
	if body.name == "TileMap":
		return
	
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
	
	if ghosts_out == 3:
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

func _on_Points(value: int):
	points += value
	$Interface/Points.text = String(points)
