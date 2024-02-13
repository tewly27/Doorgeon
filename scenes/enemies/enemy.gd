extends CharacterBody2D

@export var gravity: float
@export var player: Node2D

@export var attackRange: float
@export var agroRange: float

@export var speed: float

enum State {STATE_IDLE, STATE_CHASE, STATE_ATTACK}
var current_state: State
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	#state transitions
	var dist = global_position.distance_to(player.global_position)
	if dist <= attackRange:
		current_state = State.STATE_ATTACK
	elif dist <= agroRange:
		current_state = State.STATE_CHASE
	else:
		current_state = State.STATE_IDLE
	#state machine
	match current_state:
		State.STATE_IDLE:
			$AnimationPlayer.play("idle")
			velocity.x = 0
		State.STATE_CHASE:
			$AnimationPlayer.play("walk")
			var difference = player.global_position.x - global_position.x
			var direction = difference/abs(difference)
			velocity.x = direction * speed
		State.STATE_ATTACK:
			velocity.x = 0
			if $AnimationPlayer.current_animation != "attack":
				attack()
	#flip
	if player.global_position.x < global_position.x:
		$graphics.flip_h = false
	else:
		$graphics.flip_h = true
	print(current_state)
	move_and_slide()
func attack():
	$AnimationPlayer.play("attack")
	$enemy_projectile_spawner.spawn(global_position.distance_to(player.global_position),global_position.direction_to(player.global_position))
