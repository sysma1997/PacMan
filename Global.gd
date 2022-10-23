extends Node

signal Game_start
signal Points(value)
signal Weaken_ghosts
signal Dead_ghost(name)

func set_game_start():
	emit_signal("Game_start")

func set_point(value: int):
	emit_signal("Points", value)

func set_weaken_ghosts():
	emit_signal("Weaken_ghosts")

func set_dead_ghost(name: String):
	emit_signal("Dead_ghost", name)
