extends KinematicBody2D


"""
VAR DESCRIPTIONS:
			  ~~~EXPORT VARS~~~
	speed: speed of the movement of the character
	dash_speed: speed of the dash
	DASH_FRAMES: length of dash (in frames)
			  ~~~LOCAL VARS~~~
	dash_remain: the amount of dash frames remaining
	dash_vector: the direction times the speed of the dash
				of where the player is dashing to
"""
var velocity
export var speed = 5
export var dash_speed = 10
export var DASH_FRAMES = 15
var dash_remain
var dash_vector

# instances to base values
func _ready():
	velocity = Vector2()
	dash_vector = Vector2()
	dash_remain = 0

# handles key presses
# more info on dash below
func handle_key():
	# resets velocity so it doesn't constantly accelerate
	velocity = Vector2()
	if (Input.is_action_pressed("move_up")):
		velocity.y -= 1
	if (Input.is_action_pressed("move_down")):
		velocity.y +=1
	if (Input.is_action_pressed("move_left")):
		velocity.x -= 1
	if (Input.is_action_pressed("move_right")):
		velocity.x += 1
	# makes sure the direction is normalized in all directions
	velocity = velocity.normalized() * speed
	if (Input.is_action_just_pressed("dash")):
		player_dash()

func player_dash():
	# The dash vector is calculated by taking the directions to the mouse from the player
	# and multiplies it by the dash_speed
	dash_vector = position.direction_to(get_viewport().get_mouse_position())*dash_speed
	dash_remain = DASH_FRAMES
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# checks if player is dashing
	if(dash_remain > 0):
		# moves by dash_vector and reduces dash frames remaining
		move_and_collide(dash_vector)
		dash_remain -= 1
	else:
		# normal movement
		handle_key()
		velocity = move_and_collide(velocity)