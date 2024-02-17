extends Area2D

@export var x = 0
@export var y = 0
@export var scene: String
var onDoor = false
func _ready():
	onDoor = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("enterDoor") and onDoor:
		Global.location_x = x
		Global.location_y = y
		Global.currentScene = scene
		PlayerPrefs.set_pref("currentScene", scene)
		PlayerPrefs.set_pref("location_x", x)
		PlayerPrefs.set_pref("location_y", y)
		get_tree().change_scene_to_file(scene)


func _on_body_entered(body):
	if body.name == "player":
		$Label.visible = true
		onDoor = true


func _on_body_exited(body):
	if body.name == "player":
		$Label.visible = false
		onDoor = false
