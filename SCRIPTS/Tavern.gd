extends StaticBody2D
const game_data = preload("res://SCRIPTS/game_data.gd")

var inside = load("res://SCENES/TavernInside.tscn")
var transfer = null

func _ready():
	transfer = game_data.new()
	inside = inside.instance()

func _on_Entrance_body_entered(body):
	if(body.name == "Player"):
		
		transfer.enter_area(inside, get_tree(), get_tree().get_nodes_in_group("Player")[0], inside.get_node("Spawn").position)
