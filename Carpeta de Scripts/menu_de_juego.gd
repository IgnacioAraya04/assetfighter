extends Node2D

func _ready():
	$menu.play()


func _on_regresar_pressed():
	get_tree().change_scene_to_file("res://Escenas/main.tscn")


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu_opciones.tscn")


func _on_modo_coop_pressed():
	ModoOnline.modo_de_juego = "JvJ"
	$menu.stop()
	$pvp.play()


func _on_tabla_de_puntuaciones_pressed():
	$menu.stop()	
	$leaderboard.play()



func _on_modo_online_pressed():
	ModoOnline.modo_de_juego = "online"
	$menu.stop()	
	$online.play()


func _on_online_finished():
	get_tree().change_scene_to_file("res://Escenas/characterSelecton.tscn")	


func _on_pvp_finished():
	get_tree().change_scene_to_file("res://Escenas/characterSelecton.tscn")


func _on_leaderboard_finished():
	get_tree().change_scene_to_file("res://Escenas/leaderBoard.tscn")
