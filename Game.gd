extends Node2D

var points: int = 0

var blinky_out: bool = false
var clyde_out: bool = false
var inky_out: bool = false
var pinky_out: bool = false
var ghosts_out: int = 1

var reset_game: bool = false
var seconds_reset: float = 0

var dead_ghost_weak: int = 0
var seconds_point: float = 0

var game_start: bool = false
var player_win: bool = false

func _ready():
	$AreaDor/Dor/Collision.set_deferred("disabled", true)
	
	Global.connect("Points", self, "_on_Points")
	Global.connect("Weaken_ghosts", self, "_on_Weaken_ghosts")
	Global.connect("Dead_ghost", self, "_on_Dead_ghost")
	
	$AudioGameStart.play()

func _process(delta):
	if player_win:
		if Input.is_action_pressed("ui_select"):
			get_tree().reload_current_scene()
	
	if !$AudioGameStart.playing and !game_start:
		game_start = true
		Global.set_game_start()
	
	if $Points.visible:
		seconds_point += delta
		if seconds_point > 2:
			seconds_point = 0
			$Points.set_deferred("visible", false)
	
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
	$Blinky.queue_free()
	$Clyde.queue_free()
	$Inky.queue_free()
	$Pinky.queue_free()
	
	reset_game = true
	
	$DeadPlayer.play()

func _on_Points(value: int):
	points += value
	$Interface/Points.text = String(points)
	
	var dots = $Dots.get_children().size()
	if dots  <= 1:
		$Player.queue_free()
		$Blinky.queue_free()
		$Clyde.queue_free()
		$Inky.queue_free()
		$Pinky.queue_free()
		
		$Interface/Win.set_deferred("visible", true)
		player_win = true

func _on_Weaken_ghosts():
	dead_ghost_weak = 0

func show_points(value: int, position: Vector2):
	seconds_point = 0
	$Points.play(String(value))
	$Points.position = position
	$Points.set_deferred("visible", true)
func _on_Dead_ghost(name: String):
	$AreaDor/Dor/Collision.set_deferred("disabled", true)
	
	var point = 0
	if dead_ghost_weak == 0:
		point = 200
	elif dead_ghost_weak == 1:
		point = 400
	elif dead_ghost_weak == 2:
		point = 800
	elif dead_ghost_weak == 3:
		point = 1600
	
	points += point
	dead_ghost_weak += 1
	$Interface/Points.text = String(points)
	
	if name == "Blinky":
		ghosts_out -= 1
		blinky_out = false
		show_points(point, $Blinky.position)
	elif name == "Clyde":
		ghosts_out -= 1
		clyde_out = false
		show_points(point, $Clyde.position)
	elif name == "Inky":
		ghosts_out -= 1
		inky_out = false
		show_points(point, $Inky.position)
	elif name == "Pinky":
		ghosts_out -= 1
		pinky_out = false
		show_points(point, $Pinky.position)
