extends Area2D

func _ready():
	pass

func _on_BigDot_body_entered(body: Node):
	if body.name == "Player":
		Global.set_point(50)
		queue_free()
