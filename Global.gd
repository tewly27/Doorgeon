extends Node

var playerHp = 5
var iframe = 0
var onSpike = 0
var location_x = 0
var location_y = 0
var player : CharacterBody2D
signal damageTaken

# Called when the node enters the scene tree for the first time.
func _ready():
	iframe = 0
	playerHp = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if iframe >= 0:
		iframe -= delta
	if iframe <= 0 and onSpike > 0:
		takeDamage(1)
	
func takeDamage(damage:int):
	playerHp -= damage
	iframe = 1
	damageTaken.emit()
	
