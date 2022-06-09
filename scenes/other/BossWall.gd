extends Node2D

#wall that blocks progression
#is deleted when a boss object tells it to delete itself

var phase = 0
var phaseTimer = 0
var frame = 0

#note, shoudl only collide with players 
#actually can collide with enemies too

func _ready():
	#can be ordered by boss to add to its own group so it can call them on its death
	add_to_group("boss_wall")
	pass # Replace with function body.


func _process(delta):
	match phase:
		0:
			#phaseTimer += 1
			#if phaseTimer == 100:
				#if frame < 2:
					#demanifest()
				#else:
					#manifest()
			pass
		1:
			$spr.region_rect = Rect2(frame * Vector2(32, 0), Vector2(32, 64)) 
			if phaseTimer % 5 == 0:
				if frame > 0:
					frame -= 1
				else:
					Audsys.play_sfx("doorlock.wav")
					phaseTimer = 0
					phase = 0
		2:
			$spr.region_rect = Rect2(frame * Vector2(32, 0), Vector2(32, 64)) 
			if phaseTimer % 5 == 0:
				if frame < 4:
					frame += 1
				else:
					$coll/collbox.disabled = true
					$spr.visible = false
					phaseTimer = 0
					phase = 0
					
	pass

func manifest():
	phase = 1
	phaseTimer = 0
	$spr.visible = true
	$coll/collbox.disabled = false
	pass
	
func demanifest():
	phase = 2
	phaseTimer = 0
	pass

func insta_demanifest():
	frame = 4
	$coll/collbox.disabled = true
	$spr.visible = false
	phaseTimer = 0
	phase = 0
	pass
