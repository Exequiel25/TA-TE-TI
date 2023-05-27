extends Area2D

@onready var x = preload("res://art/x.png")
@onready var o = preload("res://art/o.png")
@onready var x_sombra = preload("res://art/x_sombra.png")
@onready var o_sombra = preload("res://art/o_sombra.png")

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$sombra.hide()
	$x_o.hide()

func _on_mouse_entered():
	if not selected:
		set_texture()
		$sombra.show()

func _on_mouse_exited():
	$sombra.hide()

func set_texture():
	if (GameData.turn):
		$x_o.texture = x
		$sombra.texture = x_sombra
	else:
		$x_o.texture = o
		$sombra.texture = o_sombra

func _on_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT and event.pressed and not selected):
			selected = true
			$sombra.hide()
			$x_o.show()
			GameData.turn = not GameData.turn
			return true
