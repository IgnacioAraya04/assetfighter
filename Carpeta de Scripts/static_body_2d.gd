extends StaticBody2D

@onready var Vidas_P1 = $UI/Vidas_P1
@onready var knight = $Knight
@onready var Vidas_P2 = $UI/Vidas_P2
@onready var adventurer = $adventurer
@onready var menuPausa = $MenuPausa
var pausa = false

func _ready():
	Vidas_P1.setMaxVidas(knight.max_vida)
	Vidas_P2.setMaxVidas(adventurer.max_vida)
	Vidas_P1.actualizar_Vida(knight.stock1)
	Vidas_P2.actualizar_Vida(adventurer.stock2)
	knight.cambia_vida.connect(Vidas_P1.actualizar_Vida)
	adventurer.cambia_vida_.connect(Vidas_P2.actualizar_Vida)
	
	
	


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
