extends Node2D

func _on_area_2d_area_entered(area):
	ModoOnline.puntuacion += 50 
	if area.is_in_group("ataque"):
		queue_free()
	pass # Replace with function body.



func _on_inmolacion_timeout():
	queue_free()
