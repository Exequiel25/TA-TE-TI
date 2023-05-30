extends TextureRect

var children = get_children()

func _ready():
	for child in children:
		if (GameData3x3.turn):
			child.x_o.texture = GameData3x3.x
			child.sombra.texture = GameData3x3.x_sombra
		else:
			child.x_o.texture = GameData3x3.o
			child.sombra.texture = GameData3x3.o_sombra
		GameData3x3.turn = not GameData3x3.turn
		
func _on_area_clicked():
	for child in children:
		if (GameData3x3.turn):
			child.x_o.texture = GameData3x3.x
			child.sombra.texture = GameData3x3.x_sombra
		else:
			child.x_o.texture = GameData3x3.o
			child.sombra.texture = GameData3x3.o_sombra
		GameData3x3.turn = not GameData3x3.turn
