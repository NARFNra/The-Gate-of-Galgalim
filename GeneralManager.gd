extends Node

var newScene
var resetScene = "example"
var optionsOn = false
var lDArray

# was gonna load options but actually ill just
# like, have them hidden
#var optionsMenu = preload("res://scenes/OptionsMenu.tscn")

func _ready():
	$Menu/VBoxContainer/Start.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func lets_change_scene(targscene):
	call_deferred("_deferred_change_scene", targscene)
	pass

func lets_start_level(targlevel):
	call_deferred("_deferred_change_level", targlevel)
	pass
	
func _deferred_change_scene(targscene):
	var s = ResourceLoader.load(targscene)
	var currentScene = get_children()
	for scenez in currentScene:
		remove_child(scenez)
		scenez.queue_free()
		
	var newS = s.instance()
	self.add_child(newS)
	pass

func _deferred_change_level(lvnum):
	var targlevel
	#use roomdata array
	lDArray = RoomData.levelData
	targlevel = lDArray[RoomData.currentLevel][2]
	_deferred_change_scene(targlevel)
	resetScene = targlevel # only saving this for levels
	RoomData.currentLevel = lvnum
	pass
	
func reset_scene():
	_deferred_change_scene(resetScene)
	pass

func spawn_options_menu():
	# flip bool
	optionsOn = not optionsOn
	# if true, it WAS false
	if optionsOn == true:
		#var newOptions = 
		if is_instance_valid($optnmenu):
			$optnmenu.show()
			#grabs focus for option button
			$optnmenu.grab_from_menu()
		else:
			print("CAN'T FIND OPTIONS MENU TO SHOW")
	else: # options menu was on
		#var newOptions = 
		if is_instance_valid($optnmenu):
			$optnmenu.hide()
			$Menu/VBoxContainer/Start.grab_focus()
		else:
			print("CAN'T FIND OPTIONS MENU TO HIDE")
	pass
