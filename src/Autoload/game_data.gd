extends Node

@onready var x = preload("res://art/x.png")
@onready var o = preload("res://art/o.png")
@onready var x_sombra = preload("res://art/x_sombra.png")
@onready var o_sombra = preload("res://art/o_sombra.png")

var turn: bool = true	# True is for 'x' and False is for 'o'
var win: bool = false

var x_score: int = 0
var o_score: int = 0

# 0 is for empty, 1 is for 'x' and 2 is for 'o'
var board = [[0,0,0],[0,0,0],[0,0,0]]

func reset_board():
	for i in range(3):
		for j in range(3):
			board[i][j] = 0

func _ready():
	reset_board()
	
func check_win():
	if board[0][0] == board[0][1] and board[0][1] == board[0][2] and board[0][0] != 0:
		return true
	elif board[1][0] == board[1][1] and board[1][1] == board[1][2] and board[1][0] != 0:
		return true
	elif board[2][0] == board[2][1] and board[2][1] == board[2][2] and board[2][0] != 0:
		return true
	elif board[0][0] == board[1][0] and board[1][0] == board[2][0] and board[0][0] != 0:
		return true
	elif board[0][1] == board[1][1] and board[1][1] == board[2][1] and board[0][1] != 0:
		return true
	elif board[0][2] == board[1][2] and board[1][2] == board[2][2] and board[0][2] != 0:
		return true
	elif board[0][0] == board[1][1] and board[1][1] == board[2][2] and board[0][0] != 0:
		return true
	elif board[0][2] == board[1][1] and board[1][1] == board[2][0] and board[0][2] != 0:
		return true
	else:
		return false

func play(pos):
	board[pos/3][pos%3] = 1 if turn else 2
	win = check_win()
	if win:
		player_won()

func player_won():
	if turn:
		x_score += 1
	else:
		o_score += 1
	reset_board()
	turn = not turn
	win = false
