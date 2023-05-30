extends Button


func _on_button_up():
	get_tree().paused = false
	GameData3x3.paused = false
	get_tree().reload_current_scene()
	GameData3x3.remove_pause_instance()
