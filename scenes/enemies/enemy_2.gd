extends CharacterBody2D


const SPEED = 150
const JUMP_VELOCITY = -400.0
var startPos: Vector2
var range = 250
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 2400
var hp: int = 3
var die = false
var patrol = false
func _ready():
	startPos = position

func takeDamage(damage :int):
	if !die:
		hp -= damage
		$StunTimer.start()
		$AnimationPlayer2.play("hit")
		$SFX/hurt.playing = true
		$SFX/hit.playing = true
		if hp <= 0:
			$AnimationPlayer.play("die")
			die = true;
			motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
	

func _physics_process(delta):
	
	
	
		
		
	if $StunTimer.time_left != 0:
		velocity.x = -600 if $Enemy2.flip_h else 600
		move_and_slide()
		return
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if die:
		velocity*=0.97
		move_and_slide()
		return
	if (Global.player.position - position).length() < range:
		velocity = (Global.player.position + Vector2(0,-75) - position).normalized() * SPEED
		range = 500
		$AnimationPlayer.play("idle")
	else :
		if (startPos - position).length() > 10:
			velocity = (startPos - position).normalized() * SPEED/2
		else :
			velocity = Vector2.ZERO
			patrol = true
		range = 250
		$AnimationPlayer.play("idle")
	if patrol and (startPos - position).length() < 100:
		velocity.y = -SPEED/2
	elif patrol:
		patrol = false
	
	if velocity.x > 0:
		$Enemy2.flip_h = true
	elif velocity.x < 0:
		$Enemy2.flip_h = false

	move_and_slide()
