extends Node

const SECONDS_PER_MINUTE = 60.0

func convert_time(time):
	var minutes = time / SECONDS_PER_MINUTE
	var seconds = fmod(time, SECONDS_PER_MINUTE)
	var milliseconds := fmod(time, 1) * 100
	
	return [minutes, seconds, milliseconds]
	
func humanize_time_format(time_array):
	return "%03d  %02d  %03d" % time_array
