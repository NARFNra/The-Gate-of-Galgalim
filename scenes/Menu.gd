extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var genman = get_node("/root/GM")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Options_pressed():
	genman.spawn_options_menu()
	pass # Replace with function body.


func _on_Start_pressed():
	genman.lets_start_level(1)
	#just gonna do this as an experiment
	pvars.playerLives = 3
	pvars.playerHP = 5
	pass # Replace with function body.
