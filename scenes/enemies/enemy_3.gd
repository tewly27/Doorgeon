extends CharacterBody2D


const SPEED = 300
const JUMP_VELOCITY = -400.0
var startPos: Vector2
var range = 250
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 2400
var hp: int = 5
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
		velocity.x = SPEED if Global.player.position.x -75 > position.x else -SPEED
		range = 500
	else :
		if (startPos - position).length() > 20:
			velocity.x = SPEED/2 if startPos.x > position.x else -SPEED/2
		else :
			velocity.x = 0
		range = 250
		
	if velocity.length() > 0:
		$AnimationPlayer.play("run")
	else :
		$AnimationPlayer.play("idle")
	if velocity.x > 0:
		$Enemy2.flip_h = true
	elif velocity.x < 0:
		$Enemy2.flip_h = false

	move_and_slide()
