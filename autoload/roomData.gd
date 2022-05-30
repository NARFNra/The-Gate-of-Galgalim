extends Node

var levelMusic = []
var currentLevel = 1

#increment for each boss etc when you wanna stop playing intro 
var cutsceneCounter = 0

func _ready():
	var i = 0
	while i < 4:
		levelMusic.append([])
		levelMusic[i] = [i + 1]
		levelMusic[i].append([])
		i += 1
	
	levelMusic[0][1] = "lejes.ogg"#"07cave.ogg"
	levelMusic[1][1] = "white"
	levelMusic[2][1] = "red"
	levelMusic[3][1] = "blue"

	print(levelMusic)
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
	print("playing level music for lv 1")
	print(levelMusic[currentLevel-1][1])
	Audsys.stop_mus()
	Audsys.play_mus(levelMusic[currentLevel-1][1], -10, 1, true)
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
	
