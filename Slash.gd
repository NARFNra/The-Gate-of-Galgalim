extends Sprite


var myTimer = 0
#var myHost = null
#myhost will be set by the protag and used to lock it to protag's body

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	myTimer += 1
	if myTimer >= 2:
		if region_rect.position.x < 80:
			region_rect.position.x += 16
			myTimer = 0
		else:
			queue_free()
	pass
	
func _physics_process(delta):
	if flip_h == false:
		position.x += 1.5
	else:
		position.x -= 1.5
		
	#foolish me, forgetting that godot handles that automatically
	#if myHost != null:
	#	if myHost is Node2D:
	#		prints(myHost, myHost.position.x, self.position.x)
	#		position.x = myHost.position.x + 16
	#		position.y = myHost.position.y
	#		prints(self.position.x, self.position.y)
	#	pass
	pass


func _on_Area2D_area_entered(area):
	#print(area)
	if area.is_in_group("damagable"):
		#print("yo")
		area.get_parent().take_damage(1)
	pass # Replace with function body.
