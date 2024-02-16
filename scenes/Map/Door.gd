extends Area2D

@export var x = 0
@export var y = 0
@export var scene: String
var onDoor = false
func _ready():
	onDoor = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("enterDoor") and onDoor:
		Global.location_x = x
		Global.location_y = y
		get_tree().change_scene_to_file(scene)


func _on_body_entered(body):
	onDoor = true


func _on_body_exited(body):
	onDoor = false
