extends CharacterBody2D

var acceleration_time: =0.15
var speed: float = 600
var jump_velocity: float = -100
var dashRange: float = 400
var gravity: float = 2400
var direction: float
var inJump = false
var attacking = true
var attackCombo = 0
var stun = false
var dashTo : Vector2
func _ready():
	position.x = Global.location_x
	position.y = Global.location_y
	Global.player = self
	Global.damageTaken.connect(damageTaken)
	$camera.position = position + Vector2(0,-150)
	
func damageTaken():
	$AnimationPlayer2.play("gethit")
	$SFX/hurt.playing = true
	velocity.x = 150 if $Smoothing2D/sprite.flip_h else -150
	velocity.y = -600
	$StunTimer.start()

#func _draw():
	#draw_line(position + Vector2(0,-78), position + Vector2(-250 if $Smoothing2D/sprite.flip_h else 250, -78),Color.WHITE)
	
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		#if the timer isn't running and you just began to fall, start coyote timer
		if $CoyoteTimer.time_left == 0 and (velocity.y < 100 and velocity.y > 0):
			$CoyoteTimer.start()
		velocity.y += gravity * delta
		
	if $StunTimer.time_left != 0:
		velocity.x = 150 if $Smoothing2D/sprite.flip_h else -150
		move_and_slide()
		return
	if $DashTimer.time_left != 0:
		$AnimationPlayer.play("dash")
		if $DashTimer2.time_left == 0:
			position = dashTo
		return
		
	if Global.dash and Input.is_action_just_pressed("dash")	 :
		var space_state = get_world_2d().direct_space_state
		# use global coordinates, not local to node
		var query = PhysicsRayQueryParameters2D.create(position+Vector2(0,-78), position + Vector2(-dashRange if $Smoothing2D/sprite.flip_h else dashRange, -78),collision_mask,[$collision])
		var result = space_state.intersect_ray(query)
		if result:
			dashTo = result.position - Vector2(-50 if $Smoothing2D/sprite.flip_h else 50, -78)
		else :
			dashTo = position + Vector2(-dashRange if $Smoothing2D/sprite.flip_h else dashRange, 0)
		$DashTimer.start()
		$DashTimer2.start()
		$AnimationPlayer.play("RESET")
		#$AnimationPlayer.play("dash")
		$SFX/dash.playing = true
		
	# either if you are on ground or in coyote time, jump on button press
	if Input.is_action_just_pressed("jump") and (is_on_floor() or $CoyoteTimer.time_left != 0) and not inJump:
		$JumpTimer.start()
		velocity.y = jump_velocity
		inJump = true
		$SFX/jump_sound.playing = true
	if is_on_floor() and inJump and velocity.y == 0:
		inJump = false
	if Input.is_action_pressed("jump") and inJump and $JumpTimer.time_left != 0:
		velocity.y +=  jump_velocity
	velocity.y = clampf(velocity.y,-2000,2000)

	direction = Input.get_axis("move_left", "move_right")
	var tween = get_tree().create_tween()

	tween.tween_property(self,"velocity:x",direction*speed,acceleration_time)
	if $Smoothing2D/sprite.flip_h and !Input.is_action_pressed("move_left"):
		velocity.x *= 0.2
	if !$Smoothing2D/sprite.flip_h and !Input.is_action_pressed("move_right"):
		velocity.x *= 0.2
	move_and_slide()	
	
	if $AttackTimer.time_left == 0:
		attacking = false
		if attackCombo >= 2:
			attackCombo = 0
	if Input.is_action_just_pressed("attack1") and $AttackTimer.time_left == 0:
		velocity.y += jump_velocity
		attacking = true
		attackCombo += 1
		$ComboTimer.start()
		$AttackTimer.start()
		
		if attackCombo == 1:
			$SFX/attack1.play()		
			if !$Smoothing2D/sprite.flip_h:
				$AnimationPlayer.play("attack1")
			else :
				$AnimationPlayer.play("attack1_2")
		if attackCombo == 2:
			$SFX/attack2.play()		
			if !$Smoothing2D/sprite.flip_h:
				$AnimationPlayer.play("attack2")
			else :
				$AnimationPlayer.play("attack2_2")
				

	if $ComboTimer.time_left == 0:
		attackCombo = 0
		
	#animation
	if attacking:
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



