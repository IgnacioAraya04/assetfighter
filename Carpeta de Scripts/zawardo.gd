extends Control

@export var minutos = 1
@export var segundos = 0
var dsec= 0
var fin = false


func	_physics_process(delta):
	if fin == false:
		if minutos > 0 and segundos <= 0:
			minutos -= 1
			segundos = 59
	

		if segundos >= 10 :
			$Control/sec.text =(str(segundos))
		else:
			$Control/sec.text = ("0"+str(segundos)) 
		if minutos >= 10 :
			$Control/min.text =(str(minutos))
		else:
			$Control/min.text =("0"+str(minutos)) 
	
		if minutos == 0 and segundos == 0:
			ModoOnline.juegoFinalizado = true
			fin = true
			

func _on_cuenta_atras_timeout():
	segundos -= 1
	
