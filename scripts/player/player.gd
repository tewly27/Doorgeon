extends CharacterBody2D

@export var acceleration_time: float
@export var speed: float
@export var jump_velocity: float
@export var gravity: float
var direction: float
var inJump = false
var attacking = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		#if the timer isn't running and you just began to fall, start coyote timer
		if $CoyoteTimer.time_left == 0 and (velocity.y < 100 and velocity.y > 0):
			$CoyoteTimer.start()
		velocity.y += gravity * delta

	# either if you are on ground or in coyote time, jump on button press
	if Input.is_action_just_pressed("jump") and (is_on_floor() or $CoyoteTimer.time_left != 0) and not inJump:
		$JumpTimer.start()
		velocity.y = jump_velocity
		inJump = true
		$SFX/jump_sound.playing = true
	if is_on_floor() and inJump and velocity.y == 0:
		inJump = false
	if Input.is_action_pressed("jump") and inJump and $JumpTimer.time_left != 0:
		velocity.y += jump_velocity

	direction = Input.get_axis("move_left", "move_right")
	var tween = get_tree().create_tween()

	tween.tween_property(self,"velocity:x",direction*speed,acceleration_time)
	if $Smoothing2D/sprite.flip_h and !Input.is_action_pressed("move_left"):
		velocity.x *= 0.2
	if !$Smoothing2D/sprite.flip_h and !Input.is_action_pressed("move_right"):
		velocity.x *= 0.2
	move_and_slide()
	if Input.is_action_just_pressed("attack1") and $AttackTimer.time_left == 0:
		velocity.y += jump_velocity
		attacking = true
		$AttackTimer.start()
		$SFX/attack1.play()
	if $AttackTimer.time_left == 0:
		attacking = false
		
	#animation
	if attacking:
		if !$Smoothing2D/sprite.flip_h:
			$AnimationPlayer.play("attack1")
		else :
			$AnimationPlayer.play("attack1_2")
		return
	if direction > 0:
		$Smoothing2D/sprite.flip_h = false
	elif direction < 0:
		$Smoothing2D/sprite.flip_h = true
	if !is_on_floor():
		if velocity.y > 0:
			$AnimationPlayer.play("jump_down")
		else:
			$AnimationPlayer.play("jump_up")
	else:
		if direction:
			if $SFX/footstep.playing ==false:
				$SFX/footstep.pitch_scale = randf_range(0.95,1.05)
				$SFX/footstep.playing = true
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("idle")

