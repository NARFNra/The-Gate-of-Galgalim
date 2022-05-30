extends Node2D

var myEnemy = preload("res://scenes/Enemy.tscn")
var myGroups = ["spawner"]
var iRespawn = true
var currentScreen = Vector2(0,0)
var myPos = Vector2(666666,666666)

func _ready():
	$Spawnicon.visible = false
	# check my current location and assign self a room
	if 1 == 1:#pvars.playerX != 666666:
		myPos = Vector2(position.x, position.y)
		
		#prints(myPos)
		
		currentScreen.x = floor(myPos.x/512)
		currentScreen.y = floor(myPos.y/512)
		
		add_to_group("room_" + str(currentScreen.x) + "_" + str(currentScreen.y))
		
		#prints(get_groups())
		
		if has_node("VisibilityNotifier2D"):
			$VisibilityNotifier2D.connect("screen_exited", self, "leave_screen")
			$VisibilityNotifier2D.connect("screen_entered", self, "enter_screen")

		
		#var csX = currentScreen.x * 512
		#var csY = currentScreen.y * 448
	pass 

func leave_screen():
	pass
	
func enter_screen():
	var mySpawn = myEnemy.instance()
	get_node("../").add_child(mySpawn)
	mySpawn.position.x = position.x
	mySpawn.position.y = position.y
	pass
#func _process(delta):
#	pass
