extends "../Enemy.gd"

var frame = 0
var phaseTimer = 0
var phase = 0
var spinSpeed = 5.55

func _ready():
	hasGrav = false
	myGrav = 0
	dispOnLeaveScreen = true
	dispLeaveRange = 16
	isProjectile = true
	set_groups("remove", ["damagable", "solid"])
	
	#can have spinspeed set by maker
	if spinSpeed == 5.55:
		spinSpeed = (randi() % 9) + 1
	pass # Replace with function body.


func _process(delta):
	$Sprite.region_rect = Rect2(frame * Vector2(16, 0), Vector2(16, 16)) 
	phaseTimer += 1
	if phaseTimer > spinSpeed:
		if frame < 3:
			frame += 1
		else:
			frame = 0
		phaseTimer = 0
	pass
