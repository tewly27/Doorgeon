extends Node

var playerHp = 5
var iframe = 1
var onSpike = 0

signal damageTaken

# Called when the node enters the scene tree for the first time.
func _ready():
	playerHp = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if iframe > 0:
		iframe -= delta
		if iframe < 0 and onSpike > 0:
			takeDamage(1)
	
func takeDamage(damage:int):
	playerHp -= damage
	iframe = 1
	print(playerHp)
	damageTaken.emit()
	
