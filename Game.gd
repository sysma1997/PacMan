extends Node2D

func _ready():
	pass

func _on_ExitLeft_body_entered(body: Node):
	if body.name == "TileMap":
		return
	
	body.position = Vector2(433, 232)

func _on_ExitRight_body_entered(body: Node):
	if body.name == "TileMap":
		return
	
	body.position = Vector2(15, 232)
