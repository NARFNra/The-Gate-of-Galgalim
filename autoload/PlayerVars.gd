extends Node

var playerX = 666666
var playerY = 666666
var playerHP = 5
var playerLives = 3

#2 = hard
#1 = normal
#0 = easy
var difficulty = 2

var cameraPosX = 666666
var cameraPosY = 666666

var isPaused = false

func _ready():
	set_pause_mode(Node.PAUSE_MODE_PROCESS)
	pass # Replace with function body.


func lock_player():
	#called by bosses and whatnot
	get_tree().call_group("protagonist", "lock_player")
	pass

func unlock_player():
	#same as lock
	get_tree().call_group("protagonist", "unlock_player")
	pass

func pause_game():
	print("pausing game")
	get_tree().paused = true
	isPaused = true
	pass

func unpause_game():
	print("unpausing game")
	get_tree().paused = false
	isPaused = false

func _process(delta):
	if isPaused == true:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_accept"):
			# If not call deferred, player was picking this up afterwards and repausing
			call_deferred("unpause_game")
			
	pass
