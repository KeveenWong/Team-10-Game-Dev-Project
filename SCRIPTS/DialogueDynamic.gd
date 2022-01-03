extends Panel

"""
TO INSTANCE THE DYNAMIC DIALOGUE:
	1. MAKE SURE DialogueDynamic IS LOADED IN THE GDSCRIPT File
		see TEST_DYNAMIC.gd for example
	2. INSTANCE THE VARIABLE USING var my_var = dialogue.instance()
		replace dialogue with whatever you named it in your file
		you can make my_var anything you want
		preferably make sure my_var is properly named
		ie. if bat: var bat_dialogue = dialogue.instance()
	3. CHANGE ANY VARIABLES YOU WANT
		to change a variable, do my_var.VARNAME = (...)
		VARNAME can be any variable defined in this file
		(...) must be of same type as VARNAME
		MAKE SURE TO CHANGE THE static_text
		BY DEFAULT, option1 is "..." and option2 is "Goodbye"
		BY DEFAULT, the next_dialogue is empty
	
	KEEP IN MIND THAT IF next_dialogue IS EMPTY, THEN ONLY option2
	WILL BE DISPLAYED, PLAN ACCORDINGLY.
	
	4. IF YOU WANT MORE DIALOGUE SLIDES
		create more dynamic dialogue instances, change their values
		then change the next_dialogue to contain the dialogues in order
		(see TEST_DYNAMIC.gd for example)
	5. ADD THIS INSTANCED VAR AS A CHILD OF THE TOPMOST PARENT
		get_parent().add_child(my_var)
		make sure you're actually using the topmost parent!!!!!
	6. RUN IT
		use my_var.showup() to display it (will stay until "Ok" is pressed)
"""

"""
VAR DESCRIPTIONS:
			  ~~~EXPORT VARS~~~
	static_text: the text that will be shown upon being clicked
	option1: the text that will be shown for the first option
	option2: the text that will be shown for the second option, or
			 only option if there is no next_dialogue
	next_dialogue: the packed scene of the next_dialogue window
	selected
"""

export var static_text = "...Hello?"
export var option1 = "..."
export var option2 = "Goodbye"
export (PackedScene) var next_dialogue


# Called when the node enters the scene tree for the first time.
func _ready():
	if (typeof(next_dialogue) == TYPE_NIL):
		$VBoxContainer/Option1.visible = false
	$VBoxContainer/Label.text = static_text
	$VBoxContainer/Option1.text = option1
	$VBoxContainer/Option2.text = option2
	self.hide()

func showup():
	self.show()
	pause_mode = PAUSE_MODE_PROCESS
	get_tree().paused = true

func _on_Option1_pressed():
	self.hide()
	var dia = next_dialogue
	get_parent().add_child(dia)
	dia.showup()

func _on_Option2_pressed():
	self.hide()
	get_tree().paused = false
	pause_mode = PAUSE_MODE_INHERIT
