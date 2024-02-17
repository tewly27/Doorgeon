extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.damageTaken.connect(updateHp)
	updateHp()


	
func updateHp():
	value = 20 * Global.playerHp
