extends Button

@onready var game_manager = GameManager
var next_level = null
var next_level_scene = null
# Called when the node enters the scene tree for the first time.
func _ready():
	next_level = game_manager.get_next_level()
	if not next_level: queue_free()
	
	next_level_scene = "res://scenes/levels/"+next_level+".tscn"
	if not ResourceLoader.exists(next_level_scene): queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_pressed():
	get_tree().change_scene_to_file(next_level_scene)
