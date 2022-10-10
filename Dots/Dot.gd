extends Area2D

func _ready():
	pass

func _on_Dot_body_entered(body: Node):
	if body.name == "Player":
		Global.set_point(10)
		queue_free()
