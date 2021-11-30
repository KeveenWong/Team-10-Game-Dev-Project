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
export var speed = 75
export var dash_speed = 175
export var DASH_FRAMES = 10
export var FRICTION = 500
var dash_remain
var dash_vector

var animationPlayer = null
var animationTree = null
var animationState = null

# FOR TESTING PURPOSES
var projectile = load("res://Projectile.tscn")

# instances to base values
func _ready():
	velocity = Vector2()
	dash_vector = Vector2()
	dash_remain = 0
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback")

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
	if(Input.is_action_just_pressed("player_shoot")):
		fire(get_viewport().get_mouse_position())

func player_dash():
	# The dash vector is calculated by taking the directions to the mouse from the player
	# and multiplies it by the dash_speed
	dash_vector = position.direction_to(get_viewport().get_mouse_position())*dash_speed
	dash_remain = DASH_FRAMES
	

"""
TEST FUNCTION FOR INSTANTIATING A FIREBALL FROM PLAYER
"""
func fire(mouse_pos):
	var fireball = projectile.instance()
	fireball.direction = position.direction_to(mouse_pos)
	fireball.position = position
	get_parent().add_child(fireball)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# checks if player is dashing
	if(dash_remain > 0):
		# moves by dash_vector and reduces dash frames remaining
		move_and_collide(dash_vector * delta)
		dash_remain -= 1
	else:
		handle_key()
		# normal movement
		if velocity != Vector2.ZERO:
			animationTree.set("parameters/Idle/blend_position", velocity)
			animationTree.set("parameters/Run/blend_position", velocity)
			animationState.travel("Run")
			velocity = move_and_collide(velocity * delta)
		else:
			animationState.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
