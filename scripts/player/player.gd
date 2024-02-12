extends CharacterBody2D

@export var acceleration_time: float
@export var speed: float
@export var jump_velocity: float
@export var gravity: float

var inJump = false

func _physics_process(delta: float) -> void:
	#print(velocity.y)
	# Add the gravity.
	if not is_on_floor():
		#if the timer isn't running and you just began to fall, start coyote timer
		if $CoyoteTimer.time_left == 0 and (velocity.y < 100 and velocity.y > 0):
			$CoyoteTimer.start()
		velocity.y += gravity * delta

	# either if you are on ground or in coyote time, jump on button press
	if Input.is_action_just_pressed("jump") and (is_on_floor() or $CoyoteTimer.time_left != 0) and !inJump:
		$JumpTimer.start()
		velocity.y = jump_velocity
		inJump = true
	if is_on_floor() and inJump and velocity.y == 0:
		inJump = false
	if Input.is_action_pressed("jump") and inJump and $JumpTimer.time_left != 0:
		velocity.y += jump_velocity

	var direction := Input.get_axis("move_left", "move_right")
	var tween = get_tree().create_tween()
	
	tween.tween_property(self,"velocity:x",direction*speed,acceleration_time)

	move_and_slide()
