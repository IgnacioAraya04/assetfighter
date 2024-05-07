extends Control


func _on_continuar_pressed():
	Input.action_press("pause")
	Engine.time_scale = 1
	pass


func _on_regresar_al_menu_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://main.tscn")
	pass


func _on_salir_del_juego_pressed():
	get_tree().quit()
	pass
