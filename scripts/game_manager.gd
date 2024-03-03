extends Node

@onready var leaderboard_manager = LeaderboardManager
@onready var current_scene = get_tree().get_current_scene()
const reset_scene = preload("res://scenes/main_menu.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_packed(reset_scene)
		
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func get_next_level():
	if not leaderboard_manager.last_level_name: return
	var regex = RegEx.new("\\d+")
