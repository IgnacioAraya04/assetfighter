extends Control


var characters = []
var playeroneselected = false

@onready var gridContainer = get_parent().get_node("GridContainer")

func _ready():
	for nameOfCharacter in get_tree().get_nodes_in_group("Charactes"):
		characters.append(nameOfCharacter)
 
func _on_fire_knight_pressed():
	if playeroneselected ==false:
		CharacterSelectionManager.player = CharacterSelectionManager.selectableCharacters["FireKnight"]
		playeroneselected = true
	else:
		CharacterSelectionManager.oponent = CharacterSelectionManager.selectableCharacters["FireKnight"]
		playeroneselected = false
		get_tree().change_scene_to_file("res://Escenas/selectormapa.tscn")


func _on_blade_keeper_pressed():
	if playeroneselected ==false:
		CharacterSelectionManager.player = CharacterSelectionManager.selectableCharacters["Bladekeeper"]
		playeroneselected = true
	else:
		CharacterSelectionManager.oponent = CharacterSelectionManager.selectableCharacters["Bladekeeper"]
		playeroneselected = false
		get_tree().change_scene_to_file("res://Escenas/selectormapa.tscn")


func _on_wind_guy_pressed():
	if playeroneselected ==false:
		CharacterSelectionManager.player = CharacterSelectionManager.selectableCharacters["WindGuy"]
		playeroneselected = true
	else:
		CharacterSelectionManager.oponent = CharacterSelectionManager.selectableCharacters["WindGuy"]
		playeroneselected = false
		get_tree().change_scene_to_file("res://Escenas/selectormapa.tscn")


func _on_adventurer_pressed():
	if playeroneselected ==false:
		CharacterSelectionManager.player = CharacterSelectionManager.selectableCharacters["Adventurer"]
		playeroneselected = true
	else:
		CharacterSelectionManager.oponent = CharacterSelectionManager.selectableCharacters["Adventurer"]
		playeroneselected = false
		get_tree().change_scene_to_file("res://Escenas/selectormapa.tscn")
