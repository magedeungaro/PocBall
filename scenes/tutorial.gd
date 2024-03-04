extends Node

var slide = 0
var upper_boundary = 4
var lower_boundary = 0
@onready var texture_rect = $TextureRect
@onready var current_slide_label = $CurrentSlide

func _on_previous_slide_pressed():
	if slide == lower_boundary:
		slide = upper_boundary
		_update_slide_and_ui()
		return
		
	slide -= 1
	_update_slide_and_ui()


func _on_next_slide_pressed():
	if slide == upper_boundary:
		slide = lower_boundary
		_update_slide_and_ui()
		return
		
	slide += 1
	_update_slide_and_ui()
	
func _update_slide_and_ui():
	if slide == 0:
		texture_rect.texture = load("res://assets/snapshots/Tutorial slide 1.png")
	elif slide == 1:
		texture_rect.texture = load("res://assets/snapshots/Tutorial slide 2.png")
	elif slide == 2:
		texture_rect.texture = load("res://assets/snapshots/Tutorial slide 3.png")
	elif slide == 3:
		texture_rect.texture = load("res://assets/snapshots/Tutorial slide 4.png")
	elif slide == 4:
		texture_rect.texture = load("res://assets/snapshots/Tutorial slide 5.png")
		
	current_slide_label.text = str(slide + 1)

func _on_back_button_pressed():
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")



