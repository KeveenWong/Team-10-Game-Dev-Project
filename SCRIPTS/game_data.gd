extends Node

# need to implement a system in the menu where we can have multiple saves
# and user can choose which to launch

const SAVE_PATH = "user://savegame.save"

func save_game():
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# check if node is an instanced scene
		if(node.filename.empty()):
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
		# checks to see if the node has a save function (what data to store)
		if(!node.has_method("save")):
			print("persistent node '%s' does not have a save() function, skipped" % node.name)
			continue
		
		# call save function for the node
		var node_data = node.call("save")
		
		save_game.store_line(to_json(node_data))
	save_game.close()

# deletes the entire tree, and renders the player in the new scene
# at the given spawn position and inserts them into a YSort
# please make sure every scene has a YSort
func enter_area(area, tree, old_player, spawn):
	var player = load("res://PLAYER/Player.tscn")
	var root = tree.get_root()
	var i = root.get_child_count()
	while i > 0:
		root.get_child(i - 1).queue_free()
		i -= 1
	player = player.instance()
	player.position = spawn
	# we use old player to keep track of stats, etc. so that we
	# don't need to read the savefile everytime.
	player.speed = old_player.speed
	player.dash_speed = old_player.dash_speed
	player.dash_frames = old_player.dash_frames
	player.friction = old_player.friction
	var y_sort = area.get_node("YSort")
	y_sort.add_child(player)
	root.add_child(area)
	

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		# save does not exist (this should never happen)
		return
	
	# to load the game we will free all the nodes to persist on the scene currently
	# and reload them
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		node.queue_free()
	
	save_game.open(SAVE_PATH, File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		
		var new_node = load(node_data["filename"]).instance()
		get_node(node_data["parent"]).add_child(new_node)
		new_node.position = Vector2(node_data["pos_x"], node_data["pos_y"])
	
		for i in node_data.keys():
			if(i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y"):
				continue
			new_node.set(i, node_data[i])
	save_game.close()
