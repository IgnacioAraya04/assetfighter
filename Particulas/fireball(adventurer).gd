extends Node2D


@export var SPEED = int(700)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta 

func destroy() :
	queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("muelte"):
		destroy()
	if area.is_in_group("daño"):
		destroy()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()	
