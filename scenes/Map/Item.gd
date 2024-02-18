extends Area2D

var onDoor = false

func _ready():
	onDoor = false
	
func _process(_delta):
	if Input.is_action_just_pressed("enterDoor") and onDoor:
		Global.dash = true
		PlayerPrefs.set_pref("dash", true)
		
		queue_free()


func _on_body_entered(body):
	if body.name == "player":
		$Label.visible = true
		onDoor = true


func _on_body_exited(body):
	if body.name == "player":
		$Label.visible = false
		onDoor = false
