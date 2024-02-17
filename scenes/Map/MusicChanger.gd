extends Node

@export var music : AudioStream
@export var v = 0
#var oldMusic: AudioStream
#var oldVolume = 0
#var change = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#change = false
	if music.resource_path == Music.stream.resource_path:
		return
	#oldMusic = Music.stream
	#oldVolume = Music.volume_db
	Music.stream = music
	Music.playing = true
	Music.volume_db = v
	
	#change = true




#func _exit_tree():
	#if change:
		#Music.stream = oldMusic
		#Music.volume_db = oldVolume
		#Music.playing = true
	
