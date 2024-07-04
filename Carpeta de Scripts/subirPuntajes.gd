extends Control

var url = "https://ucn-game-server.martux.cl/scores"
var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI3MGFmMGIxYi1hZTA4LTRlNDEtYWNiMy0wYzJhNmIxOWI2MWQiLCJrZXkiOiJURjZFcVZ1VlA5UjVETXBsTDRUSnFqSzE1IiwiaWF0IjoxNzE5NDYxNTMzLCJleHAiOjE3NTA5OTc1MzN9.hmnZcIndIQiX0IZHG2J5WkUsPyK4QUP4q7U_C2QrXc0"
var headers = ["Content-Type: application/json", "Authorization: Bearer %s" % token]

@onready var http_request = $http_request
@onready var username = $Username
@onready var send = $Send

var regex : RegEx = RegEx.new()

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		print("Conexion exitosa")
	else:
		print("La solicitud falló con el código de respuesta: %d" % response_code)

func _ready():
	if not http_request.request_completed.is_connected(self._on_request_completed):
		http_request.request_completed.connect(self._on_request_completed)
	regex.compile("\\W+")

func _es_nombre_valido(nombre : String):
	if nombre.length() > 10:
		return false
	elif regex.search_all(nombre).size() != 0:
		return false
	return true

func _on_username_focus_exited():
	var nombre = username.text
	if !_es_nombre_valido(nombre):
		$NombreInvalido.set_visible(true)
		send.set_disabled(true)
	else:
		$NombreInvalido.set_visible(false)
		send.set_disabled(false)


func _on_send_button_up():
	var data = { "playerName": username.text, "score": int(ModoOnline.puntuacion) }
	var query = JSON.stringify(data)
	http_request.request(url, headers, HTTPClient.METHOD_POST, query)
	get_tree().change_scene_to_file("res://Escenas/main.tscn")



