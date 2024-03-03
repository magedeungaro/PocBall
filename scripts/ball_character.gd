extends CharacterBody2D

@onready var animated_sprite_2d = %AnimatedSprite2D
@onready var audio_stream_player_2d = %AudioStreamPlayer2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BOOST_THRESHOLD = {
	down = 25,
	up = 26
}
const THRESHOLD_OFFSET = 6
const ANIMATION_THRESHOLD = 14
const CALCULATION_THRESHOLD = BOOST_THRESHOLD.up + THRESHOLD_OFFSET

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var boost_jump = false
var additional_boost = false

func _distance_from_floor():
	const OFFSET = 12.15
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, Vector2(position.x, 1000000))
	var result = space_state.intersect_ray(query)

	if not (result.is_empty()):
		return result.position.y - position.y - OFFSET
		
func is_going_down():
	return velocity.y > 0
	
func is_going_up():
	return not is_going_down()
	
func is_moving_sideways():
	return velocity.x != 0

func _is_boost_window(distance):
	if not distance: return false
	if is_going_down():
		return distance <= BOOST_THRESHOLD.down
	else:
		return distance <= BOOST_THRESHOLD.up
	
func _is_calculation_window(distance):
	if not distance: return false
	return distance >= BOOST_THRESHOLD.up and distance <= CALCULATION_THRESHOLD and is_going_up()
	
func _is_normal_animation_window(distance):
	if not distance: return false
	return distance >= ANIMATION_THRESHOLD and is_going_up()
		
func _change_velocity(modifier = 1):
	var jump_velocity = JUMP_VELOCITY * modifier
	# parameters here are completely arbitrary and based solely on gameplay feel
	if modifier > 1: jump_velocity /= 3
	velocity.y += jump_velocity
	
func _get_boost_modifier():
	if additional_boost:
		return 3
	elif boost_jump:
		return 1.5
	
func _handle_jump():
	var distance = _distance_from_floor()
	if is_on_floor(): 
		audio_stream_player_2d.play()
		_change_velocity()
		animated_sprite_2d.animation = "jumping"
	
	if _is_normal_animation_window(distance):
		if animated_sprite_2d.animation == "idle": pass
		animated_sprite_2d.animation = "idle"
		
	if _is_boost_window(distance) and Input.is_action_just_pressed("boost_jump"):
		boost_jump = true

	if _is_calculation_window(distance):
		if boost_jump:
			_change_velocity(_get_boost_modifier())
			boost_jump = false
			if is_moving_sideways(): additional_boost = !additional_boost
		else:
			additional_boost = false

func _physics_process(delta):
	_handle_jump()
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()
