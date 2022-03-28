extends Camera2D

onready var player = get_node("res://PLAYER/Player.tscn")

#This function gets called every frame
func _process (delta):
	position.x = player.position.x
