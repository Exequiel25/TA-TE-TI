extends Button

@export_file var next_scene_path: String = ""

func _on_button_up():
	if GameData3x3.paused:
		GameData3x3.remove_pause_instance()
	get_tree().change_scene_to_file(next_scene_path)
