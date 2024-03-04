extends Node


func play_sound(sound_scene_name):
	var current_scene = get_tree().get_current_scene()
	var sound_scene_instance = load(sound_scene_name).instantiate()
	current_scene.add_child(sound_scene_instance)
