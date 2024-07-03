extends Node2D



func _on_regresar_pressed():
	get_tree().change_scene_to_file("res://Escenas/main.tscn")


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu_opciones.tscn")


func _on_modo_coop_pressed():
	ModoOnline.modo_de_juego = "JvJ"
	get_tree().change_scene_to_file("res://Escenas/characterSelecton.tscn")


func _on_tabla_de_puntuaciones_pressed():
	get_tree().change_scene_to_file("res://Escenas/leaderBoard.tscn")



func _on_modo_online_pressed():
	ModoOnline.modo_de_juego = "online"
	get_tree().change_scene_to_file("res://Escenas/characterSelecton.tscn")
