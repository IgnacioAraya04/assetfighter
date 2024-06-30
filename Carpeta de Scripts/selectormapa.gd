extends Control




func _on_woods_pressed():
	get_tree().change_scene_to_file("res://Escenas/ModoCoop.tscn")


func _on_plain_pressed():
	get_tree().change_scene_to_file("res://Escenas/ModoSolo.tscn")
