extends Node2D

@onready var host = $Hostear
@onready var entrar = $botonEntrar
@onready var nombre = $Nombre
@onready var enviar = $enviarMensaje
@onready var mensaje = $mensaje

var nick : String
var mnj : String




func _on_hostear_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(1027)
	get_tree().set_multiplayer(SceneMultiplayer.new(),self.get_path())
	multiplayer.multiplayer_peer = peer
	pass

func _on_boton_entrar_pressed():
	
	
	pass


func joined():
	host.hide()
	entrar.hide()
	nombre.hide()
	nick = nombre.text

