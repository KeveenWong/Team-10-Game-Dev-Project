extends Node2D
"""
PLEASE READ CAREFULLY
this is all temporary. Ideally, Main should not have a script.
While we do not have a new game, save game, or load game menu,
we must run from this scene. However, an error occurs when moving
between the tavern inside and the outside. This is because I am
copying the player into a new scene, while deleting the entire old
scene. Because of the way Main was structured previously, the player
couldn't travel between areas, and was thus instanced when entering
the scene, so it turned out that going from inside the tavern to outside
would duplicate the player. Because of this, the following "fail-safe" check
was establish to maintain only one player."""

var player = null
var player_scene = load("res://PLAYER/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var all_nodes = get_children()
	for node in all_nodes:
		if(node.name == "YSort"):
			var y_nodes = node.get_children()
			for i in y_nodes:
				if(i.name == "Player"):
					player = node
					continue
	if(player == null):
		player = player_scene.instance()
		player.position = Vector2(300, 100)
		$YSort.add_child(player)

