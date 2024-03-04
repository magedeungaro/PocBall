extends Node
@onready var game_manager = GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.disable_reset_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
