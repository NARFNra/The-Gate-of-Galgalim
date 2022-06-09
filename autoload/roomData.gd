extends Node

var levelData = []
var levelMusic = []
var currentLevel = 1

#increment for each boss etc when you wanna stop playing intro 
var cutsceneCounter = 0

func _ready():
	# leveldata is an array for each level
	# each entry is
	
	# 0. Level Hardcode #
	# 1. Level Name
	# 2. Level Filename
	# 3. Level Music
	var i = 0
	while i < 4:
		levelData.append([])
		levelData[i] = [i] # was i+1, now 0 is debug
		levelData[i].append([])
		levelData[i].append([])
		levelData[i].append([])
		i += 1
		
	levelData[0][1] = "Debug Level"
	levelData[1][1] = "Level 1"
	levelData[2][1] = "x"
	levelData[3][1] = "y"
		
	levelData[0][2] = "res://scenes/levels/Node2D.tscn"
	levelData[1][2] = "res://scenes/levels/Level1.tscn"
	levelData[2][2] = "red"
	levelData[3][2] = "blue"
	
	levelData[0][3] = "07cave.ogg"#""
	levelData[1][3] = "lejes.ogg"
	levelData[2][3] = "red"
	levelData[3][3] = "blue"

	print(levelData)
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func go_to_main():
	var genman = get_node("/root/GM")
	if is_instance_valid(genman):
		genman.lets_change_scene("res://scenes/Menu.tscn")
	else:
		#this should not happen but
		get_tree().change_scene("res://scenes/Menu.tscn")
	pass

func play_level_music():
	prints("playing level music for lv ", levelData[currentLevel][0])
	print(levelData[currentLevel][3])
	Audsys.stop_mus()
	Audsys.play_mus(levelData[currentLevel][3], -10, 1, true)
	#gets level music from an array
	pass

func die_screen():
	var genman = get_node("/root/GM")
	if is_instance_valid(genman):
		genman.lets_change_scene("res://scenes/DeathScreen.tscn")
	else:
		#this should not happen but
		get_tree().change_scene("res://scenes/Menu.tscn")

func reset_level():
	pvars.playerHP = 5
	var genman = get_node("/root/GM")
	if is_instance_valid(genman):
		genman.reset_scene()
	else:
		#this should not happen but
		get_tree().change_scene("res://scenes/Menu.tscn")
	pass
	
