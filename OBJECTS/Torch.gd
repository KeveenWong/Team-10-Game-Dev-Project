extends Node2D

var animationPlayer = null
var animationTree = null
var animationState = null

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback")
	animationPlayer.play("light")
	animationPlayer.queue("lit")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
