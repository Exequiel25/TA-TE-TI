extends TextureRect

var children = get_children()

func _ready():
	for child in children:
		if (GameData.turn):
			child.x_o.texture = GameData.x
			child.sombra.texture = GameData.x_sombra
		else:
			child.x_o.texture = GameData.o
			child.sombra.texture = GameData.o_sombra
		GameData.turn = not GameData.turn
		
func _on_area_clicked():
	for child in children:
		if (GameData.turn):
			child.x_o.texture = GameData.x
			child.sombra.texture = GameData.x_sombra
		else:
			child.x_o.texture = GameData.o
			child.sombra.texture = GameData.o_sombra
		GameData.turn = not GameData.turn
