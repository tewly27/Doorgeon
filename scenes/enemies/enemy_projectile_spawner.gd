extends Node2D

var enemyProjectile = preload("res://scenes/enemies/enemy_projectile.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func spawn(distance,direction):
	var a = enemyProjectile.instantiate()
	get_tree().root.get_child(0).add_child(a)
	a.global_position = global_position
	a.start(distance,direction)
