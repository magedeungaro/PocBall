extends Node
@onready var time_utils = %TimeUtils

var time_elapsed = 0.0

func _exhibt_time(time_string):
	var label = get_node("CanvasLayer/ElapsedTimeLabel")
	label.text = time_string
	
func _process(delta):
	time_elapsed += delta
	
	var converted_time = time_utils.convert_time(time_elapsed)
	var humanized_time = time_utils.humanize_time_format(converted_time)
	_exhibt_time(humanized_time)
