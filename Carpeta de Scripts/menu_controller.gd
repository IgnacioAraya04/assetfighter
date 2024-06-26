extends Control

func _on_regresar_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu_de_juego.tscn")
	pass 

var settings_file = ConfigFile.new()

var vsync: int = 0

var audio: Vector3 = Vector3(70.0, 70.0, 70.0)


@onready var resolution_option_button = get_node("%Listado de Resoluciones")
@onready var option_container = get_node("%OptionContainer")
@onready var window_mode_dropdown = %OpcionesTipoVentana
var window_mode_options = ["Fullscreen", "Fullscreen Exclusive", "Windowed"]


func _get_resolution(index) -> Vector2i:
	var resolution_arr = resolution_option_button.get_item_text(index).split("x")
	return Vector2i(int(resolution_arr[0]), int(resolution_arr[1]))

func _check_resolution(resolution: Vector2i):
	for i in resolution_option_button.get_item_count():
		if _get_resolution(i) == resolution:
			return i

func _first_time() -> void:
	DisplayServer.window_set_size(DisplayServer.screen_get_size())
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	DisplayServer.window_set_vsync_mode(vsync)
	resolution_option_button.select(_check_resolution(DisplayServer.screen_get_size()))
	# -- Video
	settings_file.set_value("VIDEO", "Resolution", _get_resolution(resolution_option_button.get_index()))
	settings_file.set_value("VIDEO", "vsync", vsync)
	settings_file.set_value("VIDEO", "Window Mode", _get_resolution(resolution_option_button.get_index()))
	# -- audio
	settings_file.set_value("audio", "General", audio.x)
	settings_file.set_value("audio", "Music", audio.y)
	settings_file.set_value("audio", "SFX", audio.z)

	settings_file.save("res://settings.cfg")


func _load_settings():
	if settings_file.load("res://settings.cfg") != OK:
		_first_time()
	else:
		pass


func _save_settings() -> void:
	
	# -- Video
	settings_file.set_value("VIDEO", "Resolution", _get_resolution(resolution_option_button.get_index()))
	settings_file.set_value("VIDEO", "vsync", vsync)
	settings_file.set_value("VIDEO", "Window Mode", _get_resolution(resolution_option_button.get_index()))
	# -- Audio
	settings_file.set_value("audio", "General", audio.x)
	settings_file.set_value("audio", "Music", audio.y)
	settings_file.set_value("audio", "SFX", audio.z)

	settings_file.save("res://settings.cfg")


func _ready():

	resolution_option_button.select(_check_resolution(DisplayServer.screen_get_size()))
	_load_settings()

# -- VIDEO TAB --

func _on_resolution_optionbutton_item_selected(index):
	DisplayServer.window_set_size(_get_resolution(index))

# -- audio TAB --


func _on_general_h_scroll_bar_value_changed(value):
	audio.x = value


func _on_music_h_scroll_bar_value_changed(value):
	audio.y = value


func _on_sfx_h_scroll_bar_value_changed(value):
	audio.z = value


# -- Save and Exit buttons


func _on_apply_button_pressed():
	_save_settings()


func _on_vsync_option_button_item_selected(index):
	# check the documentation about vsync : https://docs.godotengine.org/en/stable/classes/class_displayserver.html#enum-displayserver-vsyncmode
	vsync = index



func _on_opciones_del_tipo_de_ventana_item_selected(index):
	var selected_mode = window_mode_options[index]
	if selected_mode == "Fullscreen":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	elif selected_mode == "Fullscreen Exclusive":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass # Replace with function body.


func _on_opciones_tipo_ventana_pressed():
	
	window_mode_dropdown.clear()
	
	for option in window_mode_options:
			window_mode_dropdown.add_item(option)

	var current_mode = DisplayServer.window_get_mode()
	if current_mode == DisplayServer.WINDOW_MODE_MAXIMIZED:
		window_mode_dropdown.select(0)  # Fullscreen
	elif current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_mode_dropdown.select(1)  # Fullscreen Exclusive
	else:
		window_mode_dropdown.select(2)  # Windowed
	pass # Replace with function body.
