extends Control


func _on_regresar_pressed():
	get_tree().change_scene_to_file("res://Escenas/main.tscn")
	pass 

var url = "https://ucn-game-server.martux.cl/scores"
var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI3MGFmMGIxYi1hZTA4LTRlNDEtYWNiMy0wYzJhNmIxOWI2MWQiLCJrZXkiOiJURjZFcVZ1VlA5UjVETXBsTDRUSnFqSzE1IiwiaWF0IjoxNzE5NDYxNTMzLCJleHAiOjE3NTA5OTc1MzN9.hmnZcIndIQiX0IZHG2J5WkUsPyK4QUP4q7U_C2QrXc0"
var headers = ["Content-Type: application/json", "Authorization: Bearer %s" % token]

@onready var http_request = $http_request
@onready var item_list = $ItemList
@onready var refresh_button = $LeaderboardContainer/Button

func _ready():
	if not http_request.request_completed.is_connected(self._on_request_completed):
		http_request.request_completed.connect(self._on_request_completed)
	if not refresh_button.pressed.is_connected(self._make_request):
		refresh_button.pressed.connect(self._make_request)
	_make_request()

func _make_request():
	http_request.request(url, headers, HTTPClient.METHOD_GET)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.new()
		var response_data = json.parse_string(body.get_string_from_utf8())
		if response_data:
			var score_list = response_data.data
			_populate_leaderboard(score_list)
		else:
			print("La respuesta JSON no contiene datos válidos.")
	else:
		print("La solicitud falló con el código de respuesta: %d" % response_code)

func _populate_leaderboard(data):
	item_list.clear()
	for i in range(data.size()):
		var entry = data[i]
		var player_name = entry["playerName"]
		var score = entry["score"]
		var position = i + 1 
		item_list.add_item("#%d %s: %d" % [position, player_name, score])
