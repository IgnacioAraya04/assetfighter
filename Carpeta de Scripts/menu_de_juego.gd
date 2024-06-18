extends Node2D


func _on_regresar_pressed():
	get_tree().change_scene_to_file("res://Escenas/main.tscn")
	pass 


func _on_modo_cooperativo_pressed():
	get_tree().change_scene_to_file("res://Escenas/characterSelecton.tscn")
	pass # Replace with function body.


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu_opciones.tscn")
	pass # Replace with function body.


func _on_modo_solo_pressed():
	get_tree().change_scene_to_file("res://Escenas/characterSelecton.tscn")
	pass # Replace with function body.


func _on_modo__pressed():
	get_tree().change_scene_to_file("res://Escenas/ModoOnline.tscn")
	pass # Replace with function body.
