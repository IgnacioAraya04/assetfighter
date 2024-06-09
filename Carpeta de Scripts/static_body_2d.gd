extends StaticBody2D

@onready var givenplayer = CharacterSelectionManager.player
@onready var givenoponent = CharacterSelectionManager.oponent

@onready var Vidas_P1 = $UI/Vidas_P1
@onready var PJ_P1 = load(CharacterSelectionManager.player).instantiate()
@onready var Vidas_P2 = $UI/Vidas_P2
@onready var Pj_P2 = load(CharacterSelectionManager.oponent).instantiate()
@onready var menuPausa = $MenuPausa
var pausa = false 

func _ready():
	SpawnChosenCharacters()
	
	
	Vidas_P1.setMaxVidas(PJ_P1.max_vida)
	Vidas_P2.setMaxVidas(Pj_P2.max_vida)
	Vidas_P1.actualizar_Vida(PJ_P1.stock)
	Vidas_P2.actualizar_Vida(Pj_P2.stock)
	PJ_P1.cambia_vida.connect(Vidas_P1.actualizar_Vida)
	Pj_P2.cambia_vida.connect(Vidas_P2.actualizar_Vida)
	
	PJ_P1.ID = 1
	Pj_P2.ID = 2
	

func SpawnChosenCharacters():

	call_deferred("add_child", PJ_P1)	
	
	call_deferred("add_child", Pj_P2)

func _process(delta):
	if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("joy_pause") :
		menuPausar()
		

func menuPausar():
	if pausa:
		menuPausa.hide()
		Engine.time_scale = 1
	else:
		menuPausa.show()
		Engine.time_scale = 0
	
	pausa = !pausa
