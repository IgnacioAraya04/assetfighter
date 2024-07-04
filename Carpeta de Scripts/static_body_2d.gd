extends StaticBody2D

@onready var givenplayer = CharacterSelectionManager.player
@onready var givenoponent = CharacterSelectionManager.oponent

@onready var Vidas_P1 = $UI/Vidas_P1
@onready var PJ_P1 = load(CharacterSelectionManager.player).instantiate()
@onready var menuPausa = $MenuPausa
var pausa = false 
var targets_scene

@onready var puntaje = $Label
@onready var tiempo = $zawardo


func _ready():
	if ModoOnline.modo_de_juego == "online":
		targets_scene = load("res://Escenas/target.tscn")
		puntaje.show()
		tiempo.show()
		
		call_deferred("add_child", PJ_P1)

		Vidas_P1.setMaxVidas(PJ_P1.max_vida)
		Vidas_P1.actualizar_Vida(PJ_P1.stock)
		PJ_P1.cambia_vida.connect(Vidas_P1.actualizar_Vida)
		PJ_P1.ID = 1
		
		
		if givenplayer == str("res://Personajes/adventurer.tscn"):
			PJ_P1.name_ = "adventurer"
		else:
				""
		#programar target practice
	
	else:
		var Vidas_P2 = $UI/Vidas_P2
		var Pj_P2 = load(CharacterSelectionManager.oponent).instantiate()
		
		call_deferred("add_child", PJ_P1)	
	
		call_deferred("add_child", Pj_P2)

		
		
		Vidas_P1.setMaxVidas(PJ_P1.max_vida)
		Vidas_P2.setMaxVidas(Pj_P2.max_vida)
		Vidas_P1.actualizar_Vida(PJ_P1.stock)
		Vidas_P2.actualizar_Vida(Pj_P2.stock)
		PJ_P1.cambia_vida.connect(Vidas_P1.actualizar_Vida)
		Pj_P2.cambia_vida.connect(Vidas_P2.actualizar_Vida)
		
		PJ_P1.ID = 1
		Pj_P2.ID = 2
		
		if givenplayer == str("res://Personajes/adventurer.tscn"):
			PJ_P1.name_ = "adventurer"
		else:
				""
		if givenoponent == str("res://Personajes/adventurer.tscn"):
			Pj_P2.name_ = "adventurer"
		else:
				""
	

func _process(delta):
	if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("joy_pause") :
		menuPausar()
	if ModoOnline.juegoFinalizado == true:
		pass #aca le agregan el que aparezca la screen de que se termino la partida
func menuPausar():
	if pausa:
		menuPausa.hide()
		Engine.time_scale = 1
	else:
		menuPausa.show()
		Engine.time_scale = 0
	
	pausa = !pausa


func _on_gen_target_timeout():
	if ModoOnline.modo_de_juego == "online":
		var target = targets_scene.instantiate()
		target.position = Vector2(randf_range(13,1069),randf_range(53,364))
		call_deferred("add_child",target)



