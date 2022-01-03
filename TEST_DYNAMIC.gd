extends Area2D

"""
VAR DESCRIPTIONS:
			  ~~~EXPORT VARS~~~
	interaction_radius: 	the size of the area of the circle
						where the player can interact with
						the node (Dialogue)
			  ~~~LOCAL VARS~~~
	in_body: checks to see if the player is in the body
	dialogue: the loaded scene of the dynamic dialogue
	dia1: instance of first dialogue
	dian: instance of nth dialogue
"""

export var interaction_radius = 90
var in_body = false
var dialogue = load("res://DialogueDynamic.tscn")
var dia1
var dia2
var dia3

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.shape.set_radius(interaction_radius)
	dia1 = dialogue.instance()
	dia2 = dialogue.instance()
	dia3 = dialogue.instance()
	dia1.static_text = "This"
	dia2.static_text = "is..."
	dia2.option2 = "I'm Bored"
	dia3.static_text = "Dynamic!"
	dia3.option2 = "cool"
	dia1.next_dialogue = dia2
	dia2.next_dialogue = dia3
	add_child(dia1)
	

func _process(delta):
	if in_body and Input.is_action_just_pressed("interact"):
		dia1.showup()

func _on_TEST_DYNAMIC_body_entered(body):
	if body.is_in_group("Player"):
		in_body = true


func _on_TEST_DYNAMIC_body_exited(body):
	if body.is_in_group("Player"):
		in_body = false

