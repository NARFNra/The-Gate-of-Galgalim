extends "../Enemy.gd"

var phase = 0
var phaseTimer = 0
var frame = 0
var waftLine = 12.0

var deadGrav = 0
var deadTerm = 0

func _ready():
	hp = 1
	pass # Replace with function body.

func _process(delta):
	match phase:
		0:
			phaseTimer += 1
			if phaseTimer % 30 > 20:
				frame = 1
				yspeed = -3
			else:
				frame = 0
				if yspeed < 0:
					yspeed = 0
				pass
				
			if phaseTimer >= 90:
				if hitFloor == true:
					phase_switch(1)
				
			if abs(pvars.playerX - position.x) < 100:
				phase_switch(1)
			pass
		1:
			phaseTimer += 1
			if phaseTimer == 1:
				frame = 1
				yspeed = -15
			if phaseTimer == 5:
				frame = 2
			if yspeed >= -2:
				frame = 1
				waftLine *= -1 #to keep things flipping
				phase_switch(2)
			pass
		2:
			phaseTimer += 1
			if phaseTimer <= 10:
				myGrav = lerp(0.5, 0.1, phaseTimer/10.0)
				terminalVelocity = lerp(10.0, 2.0, phaseTimer/10.0)
			if phaseTimer == 10:
				frame = 0
			
			if phaseTimer % 30 == 9:
				if abs(pvars.playerX - position.x) < 250:
					waftLine = 12.0 * -sign(pvars.playerX - position.x)
			elif phaseTimer % 30 > 10:
				xspeed = lerp(waftLine, 0.0, (phaseTimer % 30) / 30.0 )
			else:
				waftLine *= -1
				xspeed = 0
			
			if hitFloor == true:
				myGrav = 0.5
				terminalVelocity = 10
				xspeed = 0
				phase_switch(0)
			pass
		99:
			phaseTimer += 1
			if phaseTimer < 60:
				if myGrav < 0.5:
					myGrav = lerp(deadGrav, 0.5, phaseTimer/60.0)
				if terminalVelocity < 10:
					terminalVelocity = lerp(deadTerm, 10.0, phaseTimer/60.0)
			pass
		_:
			pass
	set_sprite()
	pass

func phase_switch(newphase):
	phaseTimer = 0
	phase = newphase
	pass

func set_sprite():
	$Sprite.region_rect = Rect2(Vector2(frame * 32,0), Vector2(32,32))

func die():
	.die()
	phase_switch(99)
	deadGrav = myGrav
	deadTerm = terminalVelocity
	pass

#func _physics_process(delta):
#	pass

#func take_damage(damage):
#	.take_damage(damage)
#	pass

