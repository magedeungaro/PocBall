extends Area2D

@onready var rising_water = $"../../RisingWater"

var water_delay_quantity = 1

func _on_body_entered(body):
	rising_water.delay_water(water_delay_quantity)
	queue_free()
