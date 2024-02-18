extends Button

@export var newGame = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



	


func _on_button_down():
	if newGame:
		PlayerPrefs.delete_all()
		Global.dash = false
		Global.doubleJump = false
		Global.currentScene = "res://scenes/Map/room1.tscn"
		Global.location_x = 0
		Global.location_y = 0
	else :
		Global.dash = PlayerPrefs.get_pref("dash", false)
		Global.doubleJump = PlayerPrefs.get_pref("doubleJump", false)
		Global.currentScene = PlayerPrefs.get_pref("currentScene", "res://scenes/Map/room1.tscn")
		Global.location_x = PlayerPrefs.get_pref("location_x", 0)
		Global.location_y = PlayerPrefs.get_pref("location_y", 0)
	get_tree().change_scene_to_file("res://main3.tscn")
