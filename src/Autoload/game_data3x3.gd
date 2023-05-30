extends Node

@onready var x = preload("res://art/x.png")
@onready var o = preload("res://art/o.png")
@onready var x_sombra = preload("res://art/x_sombra.png")
@onready var o_sombra = preload("res://art/o_sombra.png")

@onready var focus = preload("res://src/Areas/focus3x3.tscn")

var turn: bool = true	# True is for 'x' and False is for 'o'
var win: bool = false
var paused: bool = false

var x_score: int = 0
var o_score: int = 0

# 0 is for empty, 1 is for 'x' and 2 is for 'o'
var board = [[0,0,0],[0,0,0],[0,0,0]]
# first char is 'h' for horizontal, 'v' for vertical and 'd' for diagonal
# second char is 't' for top, 'm' for middle and 'b' for bottom
# third char is 'l' for left, 'c' for center and 'r' for right
var win_line = ""

var timer = Timer.new()


func reset_board():
	for i in range(3):
		for j in range(3):
			board[i][j] = 0

func _ready():
	reset_board()
	timer.connect("timeout", _on_wait_timer_timeout)
	timer.wait_time = 2
	timer.one_shot = true
	add_child(timer)

	
func check_win():
	if board[0][0] == board[0][1] and board[0][1] == board[0][2] and board[0][0] != 0:
		win_line = "htc"
		return true
	elif board[1][0] == board[1][1] and board[1][1] == board[1][2] and board[1][0] != 0:
		win_line = "hmc"
		return true
	elif board[2][0] == board[2][1] and board[2][1] == board[2][2] and board[2][0] != 0:
		win_line = "hbc"
		return true
	elif board[0][0] == board[1][0] and board[1][0] == board[2][0] and board[0][0] != 0:
		win_line = "vtl"
		return true
	elif board[0][1] == board[1][1] and board[1][1] == board[2][1] and board[0][1] != 0:
		win_line = "vtc"
		return true
	elif board[0][2] == board[1][2] and board[1][2] == board[2][2] and board[0][2] != 0:
		win_line = "vtr"
		return true
	elif board[0][0] == board[1][1] and board[1][1] == board[2][2] and board[0][0] != 0:
		win_line = "dtl"
		return true
	elif board[0][2] == board[1][1] and board[1][1] == board[2][0] and board[0][2] != 0:
		win_line = "dtr"
		return true
	else:
		return false

func play(pos):
	board[pos/3][pos%3] = 1 if turn else 2
	win = check_win()
	if win:
		player_won()
	turn = not turn

func place_marker():
	# Create a CanvasLayer called FgCanvasaLayer
	var canvas_node = CanvasLayer.new()
	canvas_node.name = "MaskCanvasLayer"
	canvas_node.layer = 1
	add_child(canvas_node)

	# Create a TextureRect called Marker
	var marker = TextureRect.new()
	marker.name = "Marker"
	# center layout
	marker.set_anchors_preset(Control.PRESET_CENTER)
	canvas_node.add_child(marker)

	# Add marker as canvas_node child
	var inst = focus.instantiate()
	inst.name = "Focus"

	# Set position and direction
	if win_line[0] == "h":	# Horizontal
		inst.rotation_degrees = 0
		if win_line[1] == "t":	# top
			inst.position.y -= 158
		elif win_line[1] == "b":	# bottom
			inst.position.y += 152
	elif win_line[0] == "v":	# Vertical
		inst.rotation_degrees = 90
		inst.position.x -= 4
		if win_line[2] == "l":	# left
			inst.position.x -= 165
		elif win_line[2] == "r":	# right
			inst.position.x += 166
	elif win_line[0] == "d":
		inst.rotation_degrees = 45 if win_line[2] == "l" else -45
		inst.scale.x = 1.2
		inst.scale.y = 1.1

	marker.add_child(inst)

func player_won():
	place_marker()
	if turn:
		x_score += 1
	else:
		o_score += 1

	timer.start()
		

func reset_game():
	# reset_board()
	win = false
	x_score = 0
	o_score = 0
	turn = true

func remove_pause_instance():
	$PantallaFinalPartida.queue_free()
	$MaskCanvasLayer.queue_free()
	reset_board()


func _on_wait_timer_timeout():
	var pause_instance = load("res://src/UI/pantalla_final_partida.tscn").instantiate()
	add_child(pause_instance)
	paused = true
	get_tree().paused = true
