extends Button
@export var leaderboard : String
@onready var leaderboard_manager = LeaderboardManager

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if not leaderboard: return

	leaderboard_manager.set_show_continue_button(false)
	leaderboard_manager.set_leaderboard_key(leaderboard)
	leaderboard_manager.set_level_name()
	leaderboard_manager.get_leaderboards(leaderboard)
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")
