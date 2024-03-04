extends Node
@onready var game_manager = GameManager

func _ready():
	game_manager.enable_reset_buttons()
