extends CharacterBody2D

@export var music : AudioStream
@export var SPEED = 0
@export var flip = false
var enemyProjectile = preload("res://blade.tscn")
const JUMP_VELOCITY = -400.0
var startPos: Vector2
var rangeAgro = 300
var rangeAgro2 = 300
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 2400
var hp: int = 50
var die = false
var patrol = false
var dieTime = 4
var agro = false

func _ready():
	dieTime = 4
	startPos = position

func takeDamage(damage :int):
	if !die:
		hp -= damage
		#$StunTimer.start()
		$AnimationPlayer2.play("hit")
		$SFX/hurt.playing = true
		$SFX/hit.playing = true
		#if hp == 50:
			#$SFX/roar.playing = true
			
		if hp <= 0:
			$AnimationPlayer.play("die")
			$AnimationPlayer2.play("die")
			die = true;
			motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
			
	

func _physics_process(delta):
	
	
	#if $StunTimer.time_left != 0:
		#velocity.x = -600 if $Enemy2.flip_h else 600
		#move_and_slide()
		#return
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if die:
		velocity*=0.97
		dieTime-=delta
		if dieTime <= 0:
			queue_free()
			get_tree().change_scene_to_file("res://main4.tscn")
		move_and_slide()
		return
	if (Global.player.position - position).length() < rangeAgro:
		velocity.x = SPEED if $Enemy2.flip_h else -SPEED
		rangeAgro = 1500
		if !agro:
			Music.stream = music
			Music.playing = true
		agro = true
		if (Global.player.position - position).length() < rangeAgro2:
			if hp > 25:
				$AnimationPlayer.play("attack1")
				rangeAgro2 = 300
			else:
				$AnimationPlayer.play("attack2")
				rangeAgro2 = 700
	else :
		rangeAgro = 300

	if hp <= 50:
		pass
		
	
	if flip:
		if Global.player.position.x > position.x:
			$Enemy2.flip_h = true
			$Enemy2.offset.x = abs($Enemy2.offset.x)
			$Spikes2.scale.x = -1
		else:
			$Enemy2.flip_h = false
			$Enemy2.offset.x = -abs($Enemy2.offset.x)
			$Spikes2.scale.x = 1

	move_and_slide()
	
func spawn():
	var a = enemyProjectile.instantiate()
	get_tree().root.get_child(0).add_child(a)
	a.global_position = Global.player.position + Vector2(0,-1000)


func _on_timer_timeout():
	if hp <= 39 and hp > 0:
		spawn()
