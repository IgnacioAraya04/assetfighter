extends Panel

@onready var sprite = $corazon1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func actualizar(whole: bool):
	if whole: sprite.frame = 0
	else: sprite.frame = 1
