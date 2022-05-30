extends "Enemy.gd"

var mySpeeds = 1
var myTimer = -1

func _ready():
	hp = 3
	pass # Replace with function body.

func _process(delta):
	if myTimer > 0:
		$Sprite.texture.fps = 3 + mySpeeds
		myTimer -= 1
		if myTimer > 39:
			mySpeeds = lerp(4, 1, ((float(myTimer)-40)/10))
		elif myTimer <= 15:
			mySpeeds = lerp(1, 4, (float(myTimer)/15))
	elif myTimer == 0:
		$Sprite.texture.fps = 4
		myTimer -= 1
		mySpeeds = 1
	pass

func _physics_process(delta):
	xspeed = -mySprite.scale.x * mySpeeds
	if hitWall:
		mySprite.scale.x *= -1
		xspeed *= -1
	pass

func take_damage(damage):
	.take_damage(damage)
	yspeed = -3
	myTimer = 50
	pass
