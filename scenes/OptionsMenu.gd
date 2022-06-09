extends Popup

onready var genman = get_node("/root/GM")

onready var difficultySelector = $crect/hb/vb2/diffdrop
onready var levelSelector = $crect/hb/vb2/lvldrop
onready var confirmButton = $crect/hb/vb2/confirm

var levelName
#var levelFile
func _ready():
	#self.modulate = Color(1,1,1,0.5)
	#show()
	difficultySelector.add_item("Easy")
	difficultySelector.add_item("Normal")
	difficultySelector.add_item("Hard")
	difficultySelector.select(pvars.difficulty)
	#update these on close menu later
	
	#add level selector
	#request list of rooms from array in roomdata
	
	var lDArray = RoomData.levelData
	
	for level in lDArray:
		levelName = "nothing"
		levelName = level[1]
		if levelName != "nothing":
			levelSelector.add_item(levelName)
		pass
	
	difficultySelector.select(RoomData.currentLevel)
	
	pass # Replace with function body.

func grab_from_menu():
	confirmButton.grab_focus()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_confirm_pressed():
	prints(difficultySelector.selected,
		difficultySelector.get_item_text(difficultySelector.selected),
		levelSelector.selected,
		levelSelector.get_item_text(levelSelector.selected))
	
	pvars.difficulty = difficultySelector.selected
	RoomData.currentLevel = levelSelector.selected
	#add the bit where it saves later here
	genman.spawn_options_menu()
	pass # Replace with function body.
