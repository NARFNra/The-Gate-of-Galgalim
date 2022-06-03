extends "../Enemy.gd"

var frame = 0
var phaseTimer = 0
var phase = 3
var vector2Player : Vector2
var facing = -1
var faceSide = 0
var ang2Down = 0

var myBulletType = preload("./beamershot.tscn")

func _ready():
	#hasGrav = false
	pass # Replace with function body.

func _process(delta):
	$Sprite.region_rect = Rect2(Vector2(frame * 32, faceSide * 80), Vector2(32, 80))
	
	vector2Player = Vector2(pvars.playerX, pvars.playerY) - Vector2(global_position.x, global_position.y)
	ang2Down = vector2Player.angle_to(Vector2.DOWN)

	if abs(ang2Down) < 0.6:
		frame = 0
	elif abs(ang2Down) < 1.2:
		frame = 1
	elif abs(ang2Down) < 1.8:
		frame = 2
	elif abs(ang2Down) < 2.6:
		frame = 3
	else:
		frame = 4
		
	if ang2Down > 0:
		#on left side
		facing = -1
		faceSide = 1
	else:
		#on right side
		facing = 1
		faceSide = 0
			
	match phase:
		3:
			phaseTimer += 1
			frame = 0
			if phaseTimer > 50:
				Audsys.play_sfx("doorlock.wav", -10)
				phase = 0
				phaseTimer = 0
		0:
			phaseTimer += 1
			print(phaseTimer)
			if phaseTimer > 100:
				phase = 1
				phaseTimer = 0
		1:
			Audsys.play_sfx("jumphigh.wav", -16)
			var myBullet = myBulletType.instance()
			get_parent().add_child(myBullet)
			myBullet.position.x = position.x
			myBullet.position.y = position.y - 24
			myBullet.xspeed = sin(ang2Down) * 2
			myBullet.yspeed = cos(ang2Down) * 2
			phase = 0
			phaseTimer = 0
		4:
			pass
	pass

func die():
	.die()
	phase = 4
	
