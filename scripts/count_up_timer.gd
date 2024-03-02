extends Node

var time_elapsed = 0.0
const SECONDS_PER_MINUTE = 60.0

func _convert_time(time_elapsed):
	var minutes = time_elapsed / SECONDS_PER_MINUTE
	var seconds = fmod(time_elapsed, SECONDS_PER_MINUTE)
	var milliseconds := fmod(time_elapsed, 1) * 100
	
	return [minutes, seconds, milliseconds]
	
func _humanize_time_format(time_array):
	return "%03d  %02d  %03d" % time_array
	
func _exhibt_time(time_string):
	var label = get_node("CanvasLayer/ElapsedTimeLabel")
	label.text = time_string
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_elapsed += delta
	
	var humanized_time = _humanize_time_format(_convert_time(time_elapsed))
	_exhibt_time(humanized_time)
