extends Area2D

@export var target_level : PackedScene
var leaderboard_key = null

func _on_body_entered(body):
	if (body.name == "BallCharacter"):
		var current_scene = get_tree().get_current_scene().get_name()
		leaderboard_key = current_scene.to_lower()
		print(leaderboard_key)
		get_tree().change_scene_to_packed(target_level)
