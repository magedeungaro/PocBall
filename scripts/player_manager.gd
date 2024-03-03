extends Node

@onready var leaderboard_manager = LeaderboardManager

var player_info = {
  name = null,
  rankings = {},
  scores = {}
}

func set_player_name(player_name):
  player_info.name = player_name

func update_current_score(leaderboard, score):
  player_info.scores[leaderboard] = int(score)

func update_current_ranking(leaderboard, data):
  var formatted_data = "1. "+player_info.name+str(" - ")+str(data.rank)+str(" - ")+str(data.score)
  player_info.rankings[leaderboard] = formatted_data
  print(player_info)
