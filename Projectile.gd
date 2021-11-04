extends Area2D
"""
VAR DESCRIPTIONS:
	~~~EXPORT VARS~~~
	BEGIN_SPEED: the initial speed of the projectile
	FINAL_SPEED: the desired final speed
	cf: the coefficient to the exponential function (honestly barely impacts anything, might as well leave at 1)
	base: the exponential base for the increase in speed function
	~~~LOCAL VARS~~~
	speed: the current speed of the projectile
	direction: the given direction towards which the projectile will travel (no need to be normalized)
	count: used for counting the x variable in the exponential function (increases with time, basically t for b^t)
"""
export var BEGIN_SPEED = 75
export var FINAL_SPEED = 500
export var cf = 1
export var base = 1.05
var speed
var direction
var count

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = BEGIN_SPEED
	# if the direction is specified, it will normalize that direction
	# if it is not specified, initialized it to right
	if(not typeof(direction) == typeof(Vector2())):
		direction = Vector2(1,0)
	else:
		direction = direction.normalized()
	count = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# the function to find the next speed
	var next_speed = BEGIN_SPEED + cf*pow(base, count)
	# checks to see if the speed reached the FINAL_SPEED yet
	if(next_speed < FINAL_SPEED):
		speed = next_speed
		count += 1
	else:
		speed = FINAL_SPEED
	position.x += direction.x*speed*delta
	position.y += direction.y*speed*delta
	
