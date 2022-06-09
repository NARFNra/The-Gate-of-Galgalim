extends Camera2D

#cameras should be loaded by the level I think,
#rather than trying bs with the protag or smth

#each area should have a setter that links to the camera, 
#and tells it what to do when the protag passes a certain point

#current screen - what screen of the level am i on
#player position is stored after being grabbed from autoload
#csx is current screen x for positioning
var currentScreen = Vector2(0,0)
var pPos = Vector2(0,0)
var csX = 0
var csY = 0

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
func _physics_process(delta):
	#updating in physics since that's when we move
	
	#this is to check if we've changed from the default
	if pvars.playerX != 666666:
		pPos = Vector2(pvars.playerX, pvars.playerY)
		
		csX = currentScreen.x * 512
		csY = currentScreen.y * 448
		var compare = csX + 512
		
		if pPos.x > compare:
			currentScreen.x += 1
			pass
		elif pPos.x < csX:
			currentScreen.x -= 1
			pass
		
		position.x = csX
		
		compare = csY + 448

		if pPos.y > compare:
			currentScreen.y += 1
			pass
		elif pPos.y < csY:
			currentScreen.y -= 1
			pass
			
		position.y = csY
		
		pvars.cameraPosX = position.x
		pvars.cameraPosY = position.y
	pass
