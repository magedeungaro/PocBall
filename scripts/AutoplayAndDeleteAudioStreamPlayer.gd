extends AudioStreamPlayer
@onready var audio_stream_player = $"."

func _ready():
	audio_stream_player.play()


func _on_finished():
	queue_free()
