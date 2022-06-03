extends "../Enemy.gd"

var myDoorGroup = "minibeetledoors"
var bossDoors = preload("res://scenes/other/BossWall.tscn")
var phase = 0
var phaseTimer = 0
var myRoom = Vector2(0, 0)
var myPosInRoom = Vector2(0, 0)
var myRoomPoint = Vector2(0, 0)
var myFacing = 1 #for silly scale bs
var changedDir = false

var accelSpeed = 0.1

var frame = 0

func _ready():
	hp = 10
	$Sprite.visible = false
	dispOnLeaveScreen = false
	dispLeaveRange = 16
	myRoom = Vector2(floor(position.x / 512), floor(position.y / 448))
	myRoomPoint = Vector2(myRoom.x * 512, myRoom.y * 448)
	myPosInRoom = position - (myRoom * Vector2(512, 448))
	myGrav = 0
	position.x += 64
	position.y += 64
	pass # Replace with function body.
	
func generate_walls():
	var myDoorInst = bossDoors.instance()
	get_node("../").add_child(myDoorInst)
	myDoorInst.position.x = 16 + (myRoom.x * 512)
	myDoorInst.position.y = 320 + (myRoom.y * 448)
	myDoorInst.insta_demanifest()
	myDoorInst.manifest()
	myDoorInst.add_to_group("minibeetledoors")
	
	myDoorInst = bossDoors.instance()
	get_node("../").add_child(myDoorInst)
	myDoorInst.position.x = ((myRoom.x + 1) * 512) - 16
	myDoorInst.position.y = 320 + (myRoom.y * 448)
	myDoorInst.insta_demanifest()
	myDoorInst.manifest()
	myDoorInst.add_to_group("minibeetledoors")
	pass

func die():
	.die()
	get_tree().call_group("minibeetledoors", "demanifest")
	Audsys.play_sfx("steam.wav", -5, 1.0, 1)
	
	#later have a real cutscene
	#however
	
	phase_switch(99)
	pass
	
func take_damage(damage):
	.take_damage(damage)
	if hp > 5:
		if hp < 9:
			accelSpeed = 0.2
			
	#for hard mode
	#else:
	#	accelSpeed = 0.3
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	phaseTimer += 1
	#0-5 frames
	$Sprite.region_rect = Rect2(frame * Vector2(48, 0), Vector2(48, 48)) 
	
	#frame = 2 + (phaseTimer % 20)/5
	
	if phaseTimer == 100:
		phaseTimer = 101
		#call_deferred("generate_walls")
		
	match phase:
		0:
			#intro, lurking in room
			if (pvars.playerX < (myRoomPoint.x + 400) && pvars.playerX > (myRoomPoint.x)):
				if (pvars.playerY > myRoomPoint.y) && (pvars.playerY < myRoomPoint.y + 448):
					Audsys.fade_out_mus(1.0)
					position.x = myRoomPoint.x - 48
					position.y = myRoomPoint.y + 336
					pvars.lock_player()
					$Sprite.visible = true
					phase_switch(1)
				pass
		1:
			xspeed = 2#4
			frame = (phaseTimer % 10) / 5
			if phaseTimer % 10 == 0:
				Audsys.play_sfx("footstep.wav", 12)
				yspeed = -2
				myGrav = 0.5
			if position.x > myRoomPoint.x + 60:
				xspeed = 0
				phase_switch(2)
			pass
		2:
			if phaseTimer == 1:
				frame = 1
			elif phaseTimer == 30:
				Audsys.play_mus("unlimit.ogg", -10.0)
			elif phaseTimer == 50:
				frame = 0
			elif phaseTimer == 60:
				Audsys.play_sfx("jumplow.wav", -6)
				yspeed = -6
				xspeed = 6
			elif phaseTimer > 60:
				if hitFloor == true:
					generate_walls()
					phase_switch(3)
			pass
		3:
			xspeed = 0
			yspeed = 0
			if phaseTimer == 60:
				$bosslabel.text = "ROACHIE"
			elif phaseTimer >= 180:
				$bosslabel.text = ""
				Audsys.play_sfx("footstep.wav", 12)
				pvars.unlock_player()
				phase_switch(4)
			pass
		4:
			$bosslabel.text = str(hp)
			frame = (phaseTimer % 10) / 5
			if phaseTimer % 10 == 0:
				Audsys.play_sfx("footstep.wav", 12)
				yspeed = -2
				
			if hitWall == true:
				if hp < 5:
					xspeed = -sign(xspeed) * 0.6
					hitWall = false
				
			if pvars.playerX > position.x:
				xspeed += accelSpeed
			else:
				xspeed -= accelSpeed
				
			if xspeed > 0:
				if myFacing != 1:
					myFacing = 1
					changedDir = true
					scale.x *= -1
					$bosslabel.rect_scale.x *= -1
			else:
				if myFacing != -1:
					myFacing = -1
					changedDir = false
					scale.x *= -1
					$bosslabel.rect_scale.x *= -1
					
			if changedDir == true:
				if hp < 7:
					if (randi() % 5) > 2:
						phase_switch(5)
				else:
					pass
				changedDir = false
			pass
		5:
			$bosslabel.text = str(hp)
			frame = 2 + (phaseTimer % 16) / 4
			if phaseTimer % 5 == 0:
				Audsys.play_sfx("footstep.wav", 16)
				
			if phaseTimer == 1:
				Audsys.play_sfx("jumplow.wav", -6)
				#trying to avoid getting stuck in wall
				move_and_slide(Vector2(myFacing * 60, 0), Vector2(0, -1))
				if randi() % 100 < 50:
					xspeed = myFacing * 10
				else:
					xspeed = myFacing * 5
					
				if randi() % 100 < 33:
					yspeed = -6
				elif randi() % 100 < 66:
					yspeed = -9
				else:
					yspeed = -12
					
				if xspeed > 5:
					yspeed *= 0.5
			
			if phaseTimer > 30:
				#dont like doing this but odd behavior
				if hitFloor == true:
					phase_switch(4)
			pass
		99:
			if phaseTimer == 1:
				xspeed = 0
				yspeed = 0
				Audsys.fade_out_mus(1.0)
			if phaseTimer == 60:
				RoomData.play_level_music()
			
			if position.y > myRoomPoint.y + 500:
				if myGrav != 0:
					position.x = -512
					position.y = -512
				myGrav = 0
				yspeed = 0
				xspeed = 0
			pass
	pass
	
func phase_switch(newphase):
	phaseTimer = 0
	phase = newphase
	pass

#label thing
#AND IS IT NOT SAID
#THE ROACH SHALL OUTLIVE MANKIND?
