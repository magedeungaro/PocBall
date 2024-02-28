extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var boost_jump = false

func distance_from_floor():
	const OFFSET = 12.15
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, Vector2(position.x, 1000000))
	var result = space_state.intersect_ray(query)

	if not (result.is_empty()):
		return result.position.y - position.y - OFFSET
		
func is_going_down():
	return velocity.y > 0
		
func is_boost_window():
	const THRESHOLD = 25
	var distance = distance_from_floor()
	return distance and is_going_down() and distance <= THRESHOLD

func is_delayed_boost():
	const THRESHOLD = 25
	var distance = distance_from_floor()
	return distance and not is_going_down() and distance <= THRESHOLD
	
func change_velocity(modifier):
	velocity.y = JUMP_VELOCITY * modifier
	
func handle_jump():
	# continuously jumping
	if is_on_floor():
		if boost_jump:
			change_velocity(1.3)
		else:
			change_velocity(1)
		boost_jump = false
	
	elif Input.is_action_just_pressed("boost_jump"):
		if is_boost_window():
			boost_jump = true
		if is_delayed_boost():
			change_velocity(1.3)
	

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
