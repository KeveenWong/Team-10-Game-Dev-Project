extends Node2D
const game_data = preload("res://SCRIPTS/game_data.gd")

var outside = load("res://SCENES/Main.tscn")
var transfer = null

func _ready():
	transfer = game_data.new()
	outside = outside.instance()

func _on_Transfer_body_entered(body):
	if(body.name == "Player"):
		transfer.enter_area(outside, get_tree(), get_tree().get_nodes_in_group("Player")[0], outside.get_node("TavernSpawn").position)
