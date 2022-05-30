extends Node

var newScene
var resetScene = "example"

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
	if lvnum == 1:
		targlevel = "res://scenes/levels/Level1.tscn"
	_deferred_change_scene(targlevel)
	resetScene = targlevel # only saving this for levels
	RoomData.currentLevel = lvnum
	pass
	
func reset_scene():
	_deferred_change_scene(resetScene)
	pass
