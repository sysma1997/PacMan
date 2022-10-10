extends Node

signal Points(value)

func set_point(value: int):
	emit_signal("Points", value)
