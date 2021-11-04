extends KinematicBody2D

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func handle_key():
	if (Input.is_mouse_button_pressed("move_up")):
		velocity.x += 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
