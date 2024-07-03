extends CharacterBody2D

signal cambia_vida

const KNOCKBACK_FORCE = 600  # Aumentado para un knockback más fuerte
const MIN_KNOCKBACK_FORCE = 200  # Valor mínimo para el knockback inicial
const SPEED = 250.0
const JUMP_VELOCITY = -600.0

var porcentaje = 0
var peso = 100
var daño = 15

@export var max_vida = 3 
@onready var stock: int  = max_vida
@onready var MAGIC = load("res://Particulas/fireball(adventurer).tscn")
@export var posicion_inicialad = Vector2(465,209)

@export var ID= 0
@export var name_= ""
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isAtacking = false
var lePegan = false
var dobleSalto = false
var knockback_direction = Vector2.ZERO
var is_knocked_back = false
var knockback_resistence = Vector2(5,5)
var knockback_tiempo = 0

func _ready():
	if ID == 1:
		global_position = posicion_inicialad
	else:
		global_position = Vector2(1405,209)
	cambia_vida.emit(stock)	
func _physics_process(delta):
	# Add the gravity
	if ID == 1:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction == +1 and lePegan == false and isAtacking == false:
			velocity.x = direction * SPEED
			$AnimatedSprite2D.flip_h = false
			get_node("areaataque").set_scale(Vector2(1, 1))
			$AnimatedSprite2D.play("run")
		elif direction == -1 and lePegan == false and isAtacking == false:
			velocity.x = direction * SPEED
			$AnimatedSprite2D.flip_h = true
			get_node("areaataque").set_scale(Vector2(-1, 1))
			$AnimatedSprite2D.play("run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if lePegan == false and isAtacking == false:
				$AnimatedSprite2D.play("idle")
		
		if not is_on_floor() and lePegan == false:
			velocity.y += gravity * delta
			if isAtacking == false:
				$AnimatedSprite2D.play("fall")
			if lePegan == true:
				$AnimatedSprite2D.play("hurt")
				lePegan = false
			if Input.is_action_just_pressed("ui_up") and dobleSalto == false:
				velocity.y = JUMP_VELOCITY
				dobleSalto = true
			if Input.is_action_just_pressed("attackp1"):
				isAtacking= true
				$areaataque/colisionataque.disabled = false
				$AnimatedSprite2D.play("airattack")

		
		if is_on_floor():
			dobleSalto = false
		
	# Handle jump.
		if Input.is_action_just_pressed("ui_up") and is_on_floor() and lePegan == false and isAtacking == false:
			$AnimatedSprite2D.play("jump")
			velocity.y = JUMP_VELOCITY
		
		if Input.is_action_just_pressed("attackp1") and is_on_floor() and lePegan == false:
			isAtacking= true
			$areaataque/colisionataque.disabled = false
			$AnimatedSprite2D.play("ataque")
		if Input.is_action_just_pressed("attackESP") and lePegan == false:
			isAtacking= true
			$areaataque/colisionataque.disabled = false
			$AnimatedSprite2D.play("ataqueESP")
			if name_ == "adventurer":
				WizardTime()

		if is_on_floor() and Input.is_action_pressed("pause"):
			position.y -=3
		if is_on_floor() and Input.is_action_pressed("ui_down"):
			position.y +=3	

		# aplicar knockback
		if is_knocked_back:
			# Modificar la fuerza del knockback para que sea parabólica
			velocity += knockback_direction * knockback_tiempo * delta
			knockback_tiempo -= delta
			if knockback_tiempo <= 0:
				is_knocked_back = false
		
		move_and_slide()
		
	if ID == 2:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("joy_left", "joy_right")
		if direction == +1 and lePegan == false and isAtacking == false:
			velocity.x = direction * SPEED
			$AnimatedSprite2D.flip_h = false
			get_node("areaataque").set_scale(Vector2(1, 1))
			$AnimatedSprite2D.play("run")
		elif direction == -1 and lePegan == false and isAtacking == false:
			velocity.x = direction * SPEED
			$AnimatedSprite2D.flip_h = true
			get_node("areaataque").set_scale(Vector2(-1, 1))
			$AnimatedSprite2D.play("run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if lePegan == false and isAtacking == false:
				$AnimatedSprite2D.play("idle")
		
		if not is_on_floor() and lePegan == false:
			velocity.y += gravity * delta
			if isAtacking == false:
				$AnimatedSprite2D.play("fall")
			if lePegan == true:
				$AnimatedSprite2D.play("hurt")
				lePegan = false
			if Input.is_action_just_pressed("joy_up") and dobleSalto == false:
				velocity.y = JUMP_VELOCITY
				dobleSalto = true
			if Input.is_action_just_pressed("joy_attack"):
				isAtacking= true
				$areaataque/colisionataque.disabled = false
				$AnimatedSprite2D.play("airattack")

		
		if is_on_floor():
			dobleSalto = false
		
	# Handle jump.
		if Input.is_action_just_pressed("joy_up") and is_on_floor() and lePegan == false and isAtacking == false:
			$AnimatedSprite2D.play("jump")
			velocity.y = JUMP_VELOCITY
		
		if Input.is_action_just_pressed("joy_attack") and is_on_floor() and lePegan == false:
			isAtacking= true
			$areaataque/colisionataque.disabled = false
			$AnimatedSprite2D.play("ataque")
		if Input.is_action_just_pressed("joy_ESP") and lePegan == false:
			isAtacking= true
			$areaataque/colisionataque.disabled = false
			$AnimatedSprite2D.play("ataqueESP")
			if $CharacterBody2D.name == "adventurer":
				print("magicshit")

		if is_on_floor() and Input.is_action_pressed("joy_pause"):
			position.y -=3
		if is_on_floor() and Input.is_action_pressed("joy_down"):
			position.y +=3	
		
		# aplicar knockback
		if is_knocked_back:
			# Modificar la fuerza del knockback para que sea parabólica
			velocity += knockback_direction * knockback_tiempo * delta
			knockback_tiempo -= delta
			if knockback_tiempo <= 0:
				is_knocked_back = false
		
		move_and_slide()
			
@onready var timer: Timer = $Timer
@onready var ganador1 = $"../Ganador1"
var explosion = preload("res://Particulas/explosion.tscn")

func _on_areadaño_area_entered(area):
	if area.is_in_group("ataque"):
		$AnimatedSprite2D.play("hurt")
		lePegan= true
		# aplicar knockback
		knockback_direction = global_position - area.global_position
		knockback_direction = knockback_direction.normalized() * max(KNOCKBACK_FORCE, MIN_KNOCKBACK_FORCE)
		knockback_direction.x *= 10  # Aumentar el componente X del knockback
		knockback_direction.y *= 1.2  # Reducir el componente Y del knockback
		knockback_resistence += Vector2(1.5, 1.5)
		is_knocked_back = true
		porcentaje += daño
		# Definir el tiempo de knockback basado en el porcentaje de daño
		knockback_tiempo = (porcentaje / peso)
	if area.is_in_group("muelte"):
		var efectoMuerte = explosion.instantiate()
		add_child(efectoMuerte)
		efectoMuerte.global_position = global_position
		stock -= 1
		cambia_vida.emit(stock)
		is_knocked_back = false
		porcentaje = 0 
		if stock > 0:
			tp()
			is_knocked_back = false
		else:
			timer.start(3)
			ganador1.show()

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "hurt":
		lePegan = false
		isAtacking = false
		$areaataque/colisionataque.disabled = true
	if $AnimatedSprite2D.animation == "ataque":
		$areaataque/colisionataque.disabled = true
		isAtacking = false
	if $AnimatedSprite2D.animation == "airattack":
		$areaataque/colisionataque.disabled = true
		isAtacking = false
	if $AnimatedSprite2D.animation == "ataqueESP":
		$areaataque/colisionataque.disabled = true
		isAtacking = false

func tp():
	global_position = posicion_inicialad
	set_physics_process(true)

func _on_timer_timeout():
	ganador1.hide()
	get_tree().change_scene_to_file("res://Escenas/main.tscn")
	pass # Replace with function body.
func WizardTime():
	if MAGIC:
		var magic = MAGIC.instantiate()
		add_child(magic)
		magic.global_position = self.global_position
		if $AnimatedSprite2D.flip_h == true:
			magic.rotate(PI)
		else:
			pass
