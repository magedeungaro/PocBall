extends Node

@onready var leaderboard_manager = LeaderboardManager
@onready var player_manager = PlayerManager
@onready var level_name = $LevelName
@onready var ranking = $Panel/Ranking
@onready var player_info = $AsidePanel/PlayerInfo
@onready var leaderboard = leaderboard_manager.leaderboard_key
const DEFAULT_TEXT = "Loading..."

func _ready():
	ranking.text = DEFAULT_TEXT
	var last_data = leaderboard_manager.last_ranking_data
	if last_data: ranking.text = last_data
	level_name.text = leaderboard_manager.last_level_name
	player_info.text = _format_player_info()

func _process(_delta):
	if ranking.text == DEFAULT_TEXT and leaderboard_manager.last_ranking_data:
		ranking.text = leaderboard_manager.last_ranking_data
		player_info.text += _format_player_rank_info()
		


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _format_player_info():
	var headline = "Current score: \n"
	var current_score = str(player_manager.player_info.scores[leaderboard]) + "\n\n"
	
	return headline + current_score

func _format_player_rank_info():
	if player_manager.player_info.rankings.size() == 0: return

	var rank_headline = "Your rank: \n"
	var current_rank = player_manager.player_info.rankings[leaderboard]
	return rank_headline + current_rank
