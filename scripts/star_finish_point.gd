extends Area2D

@export var target_level : PackedScene

@onready var leaderboard_manager = LeaderboardManager
@onready var player_manager = PlayerManager
@onready var count_up_timer = %CountUpTimer

var leaderboard_key = null

func _set_leaderboard_key():
	var current_scene = get_tree().get_current_scene().get_name()
	leaderboard_key = current_scene.to_lower()
	
func _send_player_info():
	var score = count_up_timer.time_elapsed * 1000
	player_manager.scores[leaderboard_key] = score
	var data = { score = score,
			 	 leaderboard_key = leaderboard_key }
	leaderboard_manager.send_player_info(data)

func _on_body_entered(body):
	if (body.name == "BallCharacter"):
		_set_leaderboard_key()
		_send_player_info()
		get_tree().change_scene_to_packed(target_level)
		
