extends Node2D

func _ready():
	$puntuacion.text += str(ModoOnline.puntuacion)
