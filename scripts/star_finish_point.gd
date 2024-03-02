extends Area2D

@onready var count_up_timer = %CountUpTimer
@export var target_level : PackedScene
var leaderboard_key = null

func _set_leaderboard_key():
	var current_scene = get_tree().get_current_scene().get_name()
	leaderboard_key = current_scene.to_lower()
	
func _change_scene():
	get_tree().change_scene_to_packed(target_level)
	
func _send_player_info():
	var data = { score=count_up_timer.time_elapsed,
			 	 leaderboard_key = leaderboard_key }
	print(data)

func _on_body_entered(body):
	if (body.name == "BallCharacter"):
		_set_leaderboard_key()
		_send_player_info()
		_change_scene()
		
