extends Area2D
var col:bool=false
var usado:bool = false
func _ready():
	pass

func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("personaje"):
		col=false
		body.stock+=1
		$CollisionShape2D.disabled=true
		$Sprite2D.visible=false
		usado=true


