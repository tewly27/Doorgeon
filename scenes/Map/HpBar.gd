extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.damageTaken.connect(updateHp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func updateHp():
	value = 20 * Global.playerHp
