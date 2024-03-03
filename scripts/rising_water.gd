extends Area2D

const height_to_rise = 952
const water_origin = Vector2(827, 1576)
@export var water_rising_speed : float
@export var water_retreat_speed : float

var distance_traveled_normalized = 0.0
var start_position = water_origin
var end_position = Vector2(water_origin.x, water_origin.y - height_to_rise)
var delay_water_for = 0

func delay_water(delay):
	delay_water_for += delay

func _on_body_entered(body):
	if (body.name == "BallCharacter"):
		print("player lost")

func _physics_process(delta):
	
	if delay_water_for > 0:
		distance_traveled_normalized -= delta * water_retreat_speed
		delay_water_for -= delta
		delay_water_for = max(delay_water_for, 0)
	else:
		distance_traveled_normalized += delta * water_rising_speed

	if distance_traveled_normalized <= 1:
		position = start_position.lerp(end_position, distance_traveled_normalized)
