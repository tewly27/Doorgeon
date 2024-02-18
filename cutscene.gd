extends Node2D

var num = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	num=0




func _on_button_button_down():
	num+=1
	if num >= 9:
		get_tree().change_scene_to_file(Global.currentScene)
		return
	get_node("CanvasLayer/Control/TextureRect"+str(num)).visible = false
	get_node("CanvasLayer/Control/TextureRect"+str(num+1)).visible = true


func _on_button_2_button_down():
	get_tree().change_scene_to_file(Global.currentScene)
