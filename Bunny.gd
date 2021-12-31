extends KinematicBody2D


# Declare member variables here. Examples:
var airborne = false
var timer = 0.0
var idleDuration = 1.0
var jumpPower = 70
var horizontalJumpPower = 0.8
var height = 0.0
var deceleration = 4.0
var velocity
var gravity = 200
var sprite
var animationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector3() 
	animationPlayer = $AnimationPlayer
	sprite = $Sprite
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if airborne:
		height += velocity.y * delta
		if (height <= 0):
			airborne = false
			timer = 0
			height = 0
			animationPlayer.play("Idle")
		velocity.y -= gravity * delta
		
	else:
		if (timer >= idleDuration):
			airborne = true
			animationPlayer.play("Jump")
			timer -= idleDuration
			velocity.y = jumpPower
			velocity.x = rand_range(-horizontalJumpPower, horizontalJumpPower)
			velocity.z = rand_range(-horizontalJumpPower, horizontalJumpPower)
			if (velocity.x > 0.0):
				get_node("Sprite").set_flip_h(false)
			else:
				get_node( "Sprite" ).set_flip_h(true)
		else: 
			if (velocity.x != 0):
				var initial_sign = sign(velocity.x) 
				velocity.x -= deceleration * delta * sign(velocity.x)
				if (initial_sign != sign(velocity.x)):
					velocity.x = 0
			if (velocity.z != 0):
				var initial_sign = sign(velocity.z) 
				velocity.z -= deceleration * delta * sign(velocity.z)
				if (initial_sign != sign(velocity.z)):
					velocity.z = 0
	timer += delta
	move_and_collide(Vector2(velocity.x, velocity.z))
	sprite.position.y = -height
	print(height)

