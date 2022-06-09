extends KinematicBody2D

#just using player stuff
var hp = 5
var hasGrav = true
var myGrav = 0.5
var terminalVelocity = 10.0
var yspeed = 0
var xspeed = 0

var hitWall = false
var hitFloor = false
var hitCeil = false

var dispOnLeaveScreen = true
var dispLeaveRange = 16

#respawning now handkled byspawners 
#var iRespawn = true
#var retainState = false

var isBoss = false
var isProjectile = false

var damageTimer = 0
var damageFlash = 0

var originX = 0
var originY = 0
var dead = false

var myChildren = null

var mySprite
var myColl
var myHitbox
var myHurtbox
var myVisib

#damaging, damagable, enemy, boss, projectile, ally?
var myGroups = ["damaging", "damagable", "enemy", "solid"]
var deadMat = preload("res://scenes/DeadMaterial.tres")

func _enter_tree():
	#idk ijust feel this is probably necessary
	#i feel like not resetting ready will cause chaos
	request_ready()

func _ready():
	#add the children nodes
	set_my_children()
	#set to enemy layer and check walls
	collision_layer = 0b0100
	collision_mask = 0b0001
	# delete the origin thing
	originX = position.x
	originY = position.y
	#important to add groups to area2ds
	set_groups("add", myGroups)
	#you need this to connect signals
	set_visib_range()
	#set_sleep_mode()
	pass 

func set_my_children():
	#override this in all children
	mySprite = get_node("Sprite")
	myColl = get_node("CollisionShape2D")
	myHitbox = get_node("hitbox")
	myHurtbox = get_node("hurtbox")
	myVisib = get_node("VisibilityNotifier2D")
	pass

func set_groups(addOrRemove, groups=[]):
	myChildren = get_children()
	
	if addOrRemove == "add":
		if groups.size() > 0:
			for i in groups:
				#prints(i, get_tree().get_nodes_in_group(i))
				add_to_group(i)
				if i == "damaging":
					if self.has_node("hitbox"):
						myHitbox.add_to_group(i)
				elif i == "damagable":
					if self.has_node("hurtbox"):
						myHurtbox.add_to_group(i)
				#for x in myChildren:
				#	x.add_to_group(i)
				#prints(i, get_tree().get_nodes_in_group(i))
				pass
		pass
	else:
		if groups.size() > 0:
			for i in groups:
				#prints(i, get_tree().get_nodes_in_group(i))
				remove_from_group(i)
				if i == "damaging":
					if self.has_node("hitbox"):
						myHitbox.remove_from_group(i)
				elif i == "damagable":
					if self.has_node("hurtbox"):
						myHurtbox.remove_from_group(i)
				#for x in myChildren:
				#	x.remove_from_group(i)
				#prints(i, get_tree().get_nodes_in_group(i))
				pass
		pass
	pass

func set_visib_range():
	if has_node("VisibilityNotifier2D"):
		#instead of setting it, add the range to the edges? or ignore
		#myVisib.rect = Rect2(Vector2(-dispLeaveRange, -dispLeaveRange), Vector2(dispLeaveRange * 2, dispLeaveRange * 2))
		myVisib.connect("screen_exited", self, "leave_screen")
		myVisib.connect("screen_entered", self, "enter_screen")
		pass
	pass
	
func leave_screen():
	if dead == true:
		mySprite.visible = false
	
	if dispOnLeaveScreen == true:
		queue_free()
		
	#if (iRespawn == false) && (dispOnLeaveScreen == true):
	#	queue_free()
	#elif iRespawn == true:
	#	position.x = originX
	#	position.y = originY
	#	xSpeed = 0
	#	ySpeed = 0
	#	set_sleep_mode()
	pass 

func enter_screen():
	#this isn't needed anymore probably
	#set_process(true)
	#set_physics_process(true)
	
	#if dead == true:
	#	if iRespawn == false:
	#		pass
	#	else:
	#		$Sprite.visible = true
	pass 
	
func set_sleep_mode():
	set_process(false)
	set_physics_process(false)
	pass

func _process(delta):
	if damageTimer > 0:
		damageTimer -= 1
		if damageTimer % 4 >= 2:
			damageFlash = 1
			mySprite.set_visible(false)
		else:
			damageFlash = 0
			mySprite.set_visible(true)
	pass

#so this is very annoying but i'm going to need
#to have the area 2ds all extend the existing one
#or some shit
#get rid of the sprite set visibles and
#the hitsnds for when extending
#these are just to test intent and
#will need to be done on an enemy by
#enemy basis
func take_damage(damage):
	if is_in_group("damagable"):
		if damageTimer == 0:
			hp -= damage
			if hp < 1:
				Audsys.play_sfx("explode.wav", -2.0)
				die()
			else:
				Audsys.play_sfx("damage.wav", -2.0)
				damageTimer = 30
	pass

func die():
	dead = true
	set_groups("remove", ["damagable", "damaging"])
	yspeed = -3
	hasGrav = true
	myGrav = 0.5
	#dead objects lose all collision
	mySprite.material = deadMat
	collision_layer = 0b0000
	collision_mask = 0b0000
	#queue_free()
	pass

func _physics_process(delta):
	handle_gravity()
	xyspeed()
	#done by signal
	#screen_check()
	pass
	
func handle_gravity():
	if hasGrav == true:
		#if not on floor, yspeed increases by grav
		if !is_on_floor():
			if yspeed < terminalVelocity:
				yspeed += myGrav
		pass
	pass

func xyspeed():
	move_and_slide(Vector2(xspeed * 60, 0), Vector2(0, -1))
	hitWall = is_on_wall()
	move_and_slide(Vector2(0, yspeed * 60), Vector2(0, -1))
	hitFloor = is_on_floor()
	hitCeil = is_on_ceiling()
	pass


