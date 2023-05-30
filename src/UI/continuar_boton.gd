extends Button


func _on_button_up():
    GameData3x3.reset_game()
    get_tree().paused = false
    get_tree().change_scene_to_file("res://src/Tableros/tablero_3x_3.tscn")