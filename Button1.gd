extends Button

@export var newGame = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_button_down():
	if newGame:
		PlayerPrefs.delete_all()
	else :
		Global.dash = PlayerPrefs.get_pref("dash", true)
		Global.currentScene = PlayerPrefs.get_pref("currentScene", "res://scenes/Map/room1.tscn")
		Global.location_x = PlayerPrefs.get_pref("location_x", 0)
		Global.location_y = PlayerPrefs.get_pref("location_y", 0)
	get_tree().change_scene_to_file(Global.currentScene)
