extends Control

var playerLives
var currentText
var myTimer = 0
var myLabel = null

func _ready():
	playerLives = pvars.playerLives
	myLabel = $ColorRect/Label
	pass # Replace with function body.


func _process(delta):
	myTimer += 1
	if myTimer == 1:
		Audsys.play_sfx("beep.wav", -10)
		myLabel.text = "_"
	if myTimer == 30:
		myLabel.text = ""
	if myTimer == 60:
		Audsys.play_sfx("beep.wav", -10)
		myLabel.text = "_"
	if myTimer == 90:
		myLabel.text = ""
	if myTimer == 120:
		Audsys.play_sfx("beep.wav", -10)
		myLabel.text = "_"
	if myTimer == 150:
		myLabel.text = ""
	if myTimer == 180:
		Audsys.play_mus("longbeep.wav", -10)
		myLabel.text = str(playerLives)
	if myTimer == 400:
		if pvars.playerLives > 0:
			RoomData.reset_level()
		else:
			#for now, until i can make better gameover
			Audsys.stop_mus()
			Audsys.stop_sfx()
			get_tree().reload_current_scene()
	pass
