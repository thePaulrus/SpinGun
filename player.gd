extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO


func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("right"):
		direction.x += speed
	if Input.is_action_pressed("left"):
		direction.x -= speed
	if Input.is_action_pressed("back"):
		direction.z += speed
	if Input.is_action_pressed("forward"):
		direction.z -= speed

	# Ground Velocity
	target_velocity.x = direction.x * speed * delta
	target_velocity.z = direction.z * speed * delta

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	
	#looking?
func _unhandled_input(event: InputEvent) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var rotation_speed: float = 0.005
	if event is InputEventMouseMotion:
		var mouse_motion_event: InputEventMouseMotion = event as InputEventMouseMotion
		rotation.y -= mouse_motion_event.relative.x * rotation_speed
		rotation.x -= mouse_motion_event.relative.y * rotation_speed
		rotation.x = clampf(rotation.x, PI/-2, PI/2)
