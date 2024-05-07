extends StaticBody2D

@onready var menuPausa = $MenuPausa
var pausa = false


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		menuPausar()
		

func menuPausar():
	if pausa:
		menuPausa.hide()
		Engine.time_scale = 1
	else:
		menuPausa.show()
		Engine.time_scale = 0
	
	pausa = !pausa
