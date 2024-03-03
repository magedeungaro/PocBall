extends Node

@onready var leaderboard_manager = LeaderboardManager
@onready var level_name = $LevelName
@onready var ranking = $Panel/Ranking
const DEFAULT_TEXT = "Loading..."

func _ready():
	ranking.text = DEFAULT_TEXT
	var last_data = leaderboard_manager.last_ranking_data
	if last_data: ranking.text = last_data
	level_name = leaderboard_manager.last_level_name

func _process(_delta):
	if ranking.text == DEFAULT_TEXT and leaderboard_manager.last_ranking_data:
		ranking.text = leaderboard_manager.last_ranking_data
