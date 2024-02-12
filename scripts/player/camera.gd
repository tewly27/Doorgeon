extends Node2D
@onready var player = get_parent()
@export var moveTime: float
@export var aheadDistance: float = 300
@export var verticalMoveTime: float
@export var verticalMoveSpeed: float
@export var vertical_offset: float
@export var y_follow = true
@export var x_follow = true
var vertical_look_direction: float
func _ready() -> void:
	pass



func _process(delta: float) -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	#x axis movement
	if x_follow:
		tween.tween_property(self,"global_position:x",player.global_position.x+player.direction*aheadDistance,moveTime)
	
	#y axis movement
	vertical_look_direction = Input.get_axis("look_up","look_down")
	if y_follow:
		if vertical_look_direction:
			tween.tween_property(self,"global_position:y",player.global_position.y+vertical_offset+vertical_look_direction*aheadDistance,verticalMoveTime)
		
		else:
			tween.tween_property(self,"global_position:y",player.global_position.y+vertical_offset,verticalMoveTime)

