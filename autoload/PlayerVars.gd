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

func _ready():
	pass # Replace with function body.


func lock_player():
	#called by bosses and whatnot
	get_tree().call_group("protagonist", "lock_player")
	pass

func unlock_player():
	#same as lock
	get_tree().call_group("protagonist", "unlock_player")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
