extends Node2D


func _on_regresar_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	pass 


func _on_modo_cooperativo_pressed():
	get_tree().change_scene_to_file("res://MundoVientito.tscn")
	pass # Replace with function body.


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://menu_opciones.tscn")
	pass # Replace with function body.
