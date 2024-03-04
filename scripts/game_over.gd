extends Node
@onready var leaderboard_manager = LeaderboardManager
@onready var game_manager = GameManager


# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.disable_reset_buttons()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_try_again_button_pressed():
	var scene_name = leaderboard_manager.leaderboard_key
	get_tree().change_scene_to_file("res://scenes/levels/"+scene_name+".tscn")


func _on_leaderboard_button_pressed():
	leaderboard_manager.get_leaderboards(leaderboard_manager.leaderboard_key)
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")
