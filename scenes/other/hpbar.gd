extends Node2D

var frame = 0
var currentlyOn = true

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = pvars.cameraPosX + 32
	position.y = pvars.cameraPosY + 32
	
	$Hpbar.region_rect = Rect2(frame * Vector2(32, 0), Vector2(32, 32)) 
	
	if pvars.playerHP < 5:
		frame = 5 - pvars.playerHP
	pass
