extends Control


var characters = []


@onready var gridContainer = get_parent().get_node("GridContainer")

func _ready():
	for nameOfCharacter in get_tree().get_nodes_in_group("Charactes"):
		characters.append(nameOfCharacter)
 
	
