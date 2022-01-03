extends Area2D

"""
VAR DESCRIPTIONS:
			  ~~~EXPORT VARS~~~
	interaction_radius: 	the size of the area of the circle
						where the player can interact with
						the node (Dialogue)
			  ~~~LOCAL VARS~~~
	in_body: checks to see if the player is in the body
	dialogue: the loaded scene of the static dialogue
	dia: instance of dialogue
"""

export var interaction_radius = 90
var in_body = false
var dialogue = load("res://DialogueStatic.tscn")
var dia

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.shape.set_radius(interaction_radius)
	dia = dialogue.instance()
	dia.static_text = "This is sample dialogue"
	add_child(dia)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_body and Input.is_action_just_pressed("interact"):
		dia.showup()


func _on_TEST_DIALOGUE_body_entered(body):
	if body.is_in_group("Player"):
		in_body = true


func _on_TEST_DIALOGUE_body_exited(body):
	if body.is_in_group("Player"):
		in_body = false
