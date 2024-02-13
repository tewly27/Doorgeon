extends Node2D

@export var speed: float
var distance: float
var direction: Vector2
var up = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func start(dist,dir):
	direction = dir
	distance = dist
	$Timer.wait_time = distance/(2*speed)
	$Timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += speed*direction*delta
	var tween = get_tree().create_tween()
	if up:
		tween.tween_property($Area2D,"position:y",-100,distance/(2*speed)).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	else:
		
		tween.tween_property($Area2D,"position:y",0,distance/(2*speed)).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	print($Area2D.position.y)


func _on_timer_timeout() -> void:
	up = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()
