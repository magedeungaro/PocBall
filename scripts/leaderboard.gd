extends Node

@onready var leaderboard_manager = LeaderboardManager
@onready var player_manager = PlayerManager
@onready var sound_manager = SoundManager
@onready var level_name = $LevelName
@onready var ranking = $Panel/Ranking
@onready var player_info = $AsidePanel/PlayerInfo
@onready var continue_button = $ContinueButton
@onready var leaderboard = leaderboard_manager.leaderboard_key
const DEFAULT_TEXT = "Loading..."
const DEFAULT_PLAYER_INFO = ""

func _ready():
	_handle_play_winning_sound()
	_handle_continue_button()
	ranking.text = DEFAULT_TEXT
	level_name.text = leaderboard_manager.last_level_name
	_handle_display_player_info()

func _process(_delta):
	_handle_display_leaderboard_info()

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _handle_display_leaderboard_info():
	if ranking.text == DEFAULT_TEXT and leaderboard_manager.last_ranking_data:
		ranking.text = leaderboard_manager.last_ranking_data
		if _format_player_rank_info(): player_info.text += _format_player_rank_info()

func _handle_display_player_info():
	var previous_player_info = _format_player_info()
	if previous_player_info:
		player_info.text = previous_player_info
	else: player_info.text = DEFAULT_PLAYER_INFO

func _format_player_info():
	if leaderboard in player_manager.player_info.scores:
		var headline = "Current score: \n"
		var current_score = str(player_manager.player_info.scores[leaderboard]) + "\n\n"
		return headline + current_score

func _format_player_rank_info():
	if leaderboard in player_manager.player_info.rankings:
		var rank_headline = "Your rank: \n"
		var current_rank = player_manager.player_info.rankings[leaderboard]
		return rank_headline + current_rank
		
func _handle_continue_button():
	if not leaderboard_manager.show_continue_button:
		continue_button.queue_free()
		
func _handle_play_winning_sound():
	if leaderboard_manager.show_continue_button:
		sound_manager.play_sound("res://scenes/sound_scenes/star_pickup_sound.tscn")
