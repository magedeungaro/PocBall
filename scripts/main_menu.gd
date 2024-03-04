extends Node
@onready var player_manager = PlayerManager
@onready var game_manager = GameManager
@onready var name_input = preload("res://scenes/ui_elements/name_popup.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.disable_reset_buttons()
	if not player_manager.player_info.name:
		add_child(name_input.instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")


func _on_level_selection_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_selection.tscn")


func _on_leaderboards_button_pressed():
	get_tree().change_scene_to_file("res://scenes/leaderboard_selection.tscn")


func _on_name_button_pressed():
	add_child(name_input.instantiate())


func _on_tutorial_button_pressed():
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
