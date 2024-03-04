extends Node
@onready var leaderboard_manager = LeaderboardManager
@onready var player_manager = PlayerManager
@onready var name_input = $CanvasLayer/Panel/NameInput
@onready var headline = $CanvasLayer/Headline
@onready var close_button = $CanvasLayer/Panel/CloseButton

const START_HEADLINE = "Enter your name"

func _on_accept_button_pressed():
	var new_player_name = name_input.text
	leaderboard_manager.change_player_name(new_player_name)
	queue_free()

func _on_close_button_pressed():
	queue_free()

func _ready():
	if player_manager.player_info.name:
		name_input.text = player_manager.player_info.name
	else:
		headline.text = START_HEADLINE
		close_button.queue_free()
