extends Control

@onready var juego = $".."

func _on_continuar_pressed():
	juego.menuPausar()
	pass


func _on_regresar_al_menu_pressed():
	juego.menuPausar()
	get_tree().change_scene_to_file("res://Escenas/main.tscn")
	pass


func _on_salir_del_juego_pressed():
	get_tree().quit()
	pass
