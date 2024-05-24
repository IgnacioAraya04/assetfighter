extends HBoxContainer

@onready var VidasUiClass = preload("res://UI/Vidas/vida_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setMaxVidas(max_: int):
	for i in range(max_):
		var vida = VidasUiClass.instantiate()
		add_child(vida)
		
func actualizar_Vida(stock1: int):
	var vidas = get_children()
	
	for i in range(stock1):
		vidas[i].actualizar(true)
	for i in range(stock1, vidas.size()):
		vidas[i].actualizar(false)
