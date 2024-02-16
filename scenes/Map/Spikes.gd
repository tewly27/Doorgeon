extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "player":
		#Global.takeDamage(1)
		Global.onSpike+=1

func _on_body_exited(body):
	Global.onSpike-=1
