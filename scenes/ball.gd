extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BOOST_THRESHOLD = {
	down = 25,
	up = 13
}
const CALCULATION_THRESHOLD = BOOST_THRESHOLD.up + 6

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var boost_jump = false
var additional_boost = 0

func distance_from_floor():
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

func is_boost_window(distance):
	if not distance: return false
	if is_going_down():
		return distance <= BOOST_THRESHOLD.down
	else:
		return distance <= BOOST_THRESHOLD.up
	
func is_calculation_window(distance):
	if not distance: return false
	return distance >= BOOST_THRESHOLD.up and distance <= CALCULATION_THRESHOLD and is_going_up()
		
func change_velocity(modifier):
	velocity.y = JUMP_VELOCITY * modifier
	
func get_boost_modifier():
	if additional_boost:
		return 1.7
	elif boost_jump:
		return 1.3
	
func handle_jump():
	var distance = distance_from_floor()
	if is_going_up(): print(distance)
	if is_on_floor(): change_velocity(1)
	if is_boost_window(distance) and Input.is_action_just_pressed("boost_jump"):
		boost_jump = true

	if is_calculation_window(distance):
		if boost_jump:
			change_velocity(get_boost_modifier())
			boost_jump = false
			additional_boost = true
		else:
			additional_boost = false

func _physics_process(delta):
	handle_jump()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
