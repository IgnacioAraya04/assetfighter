extends Node2D

func _ready():
	$menu.play()


func _on_jugar_pressed():
	$menu.stop()
	$jugar.play()
	pass


func _on_salir_pressed():
	get_tree().quit()
	pass 


func _on_jugar_finished():
	get_tree().change_scene_to_file("res://Escenas/menu_de_juego.tscn")
