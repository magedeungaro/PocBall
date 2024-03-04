extends Area2D

@onready var rising_water = $"../../RisingWater"
@onready var sound_manager = SoundManager

var water_delay_quantity = 1

func _on_body_entered(_body):
	rising_water.delay_water(water_delay_quantity)
	sound_manager.play_sound("res://scenes/sound_scenes/faucet_collectable_sound.tscn")
	queue_free()
