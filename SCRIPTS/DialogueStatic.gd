extends Panel

"""
TO INSTANCE THE STATIC DIALOGUE:
	1. MAKE SURE DialogueStatic IS LOADED IN THE GDSCRIPT File
		see TEST_DIALOGUE.gd for example
	2. INSTANCE THE VARIABLE USING var my_var = dialogue.instance()
		replace dialogue with whatever you named it in your file
		you can make my_var anything you want
		preferably make sure my_var is properly named
		ie. if sign: var sign_dialogue = dialogue.instance()
	3. CHANGE ANY VARIABLES YOU WANT
		to change a variable, do my_var.VARNAME = (...)
		VARNAME can be any variable defined in this file
		(...) must be of same type as VARNAME
		MAKE SURE TO CHANGE THE static_text
	4. ADD THIS INSTANCED VAR AS A CHILD OF THE TOPMOST PARENT
		get_parent().add_child(my_var)
		make sure you're actually using the topmost parent!!!!!
	5. RUN IT
		use my_var.showup() to display it (will stay until "Ok" is pressed)
"""

"""
VAR DESCRIPTIONS:
			  ~~~EXPORT VARS~~~
	static_text: the text that will be shown upon being clicked
			  ~~~LOCAL VARS~~~
	ok: keeps track to see if "ok" is pressed (pause/unpause
		functionsality)
"""
export var static_text = "...Hello?"
var ok = true

# Called when the node enters the scene tree for the first time.
func _ready():
	ok = true
	$Label.text = static_text
	self.hide()

func showup():
	self.show()
	ok = false
	pause_mode = PAUSE_MODE_PROCESS
	get_tree().paused = true

func _on_TextureButton_pressed():
	ok = true
	self.hide()
	get_tree().paused = false
	pause_mode = PAUSE_MODE_INHERIT
