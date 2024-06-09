extends CharacterBody2D

signal cambia_vida

const KNOCKBACK_FORCE = 440
const SPEED = 250.0
const JUMP_VELOCITY = -600.0

var porcentaje = 0
var peso = 100
var daño = 15

@export var max_vida = 3 
@onready var stock: int  = max_vida
@export var posicion_inicialad = Vector2(399.683,208.005)

@export var ID= 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isAtacking = false
var lePegan = false
var dobleSalto = false
var knockback_direction = Vector2.ZERO
var is_knocked_back = false

func _ready():
	if 	ID == 1 :
		global_position = posicion_inicialad
	else: 
		global_position = Vector2(599.683,208.005)
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
			if Input.is_action_just_pressed("attackp2"):
				isAtacking= true
				$areaataque/colisionataque.disabled = false
				$AnimatedSprite2D.play("airatack")

		
		if is_on_floor():
			dobleSalto = false
		
	# Handle jump.
		if Input.is_action_just_pressed("ui_up") and is_on_floor() and lePegan == false and isAtacking == false:
			$AnimatedSprite2D.play("jump")
			velocity.y = JUMP_VELOCITY
		
		if Input.is_action_just_pressed("attackp2") and is_on_floor() and lePegan == false:
			isAtacking= true
			$areaataque/colisionataque.disabled = false
			$AnimatedSprite2D.play("ataque")

		if is_on_floor() and Input.is_action_pressed("pause"):
			position.y -=3
		if is_on_floor() and Input.is_action_pressed("ui_down"):
			position.y +=3	
		# aplicar knockback
		if is_knocked_back:
			knockback_direction *= 3
			#añadir la fuerza del knockback a la velocidad
			velocity += knockback_direction * (KNOCKBACK_FORCE+porcentaje)
			# comprobar si el knockback ha terminado
			if knockback_direction.length() < 10:
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
				$AnimatedSprite2D.play("airatack")

		
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

		if is_on_floor() and Input.is_action_pressed("joy_pause"):
			position.y -=3
		if is_on_floor() and Input.is_action_pressed("joy_down"):
			position.y +=3	
		# aplicar knockback
		if is_knocked_back:
			knockback_direction *= 3
			#añadir la fuerza del knockback a la velocidad
			velocity += knockback_direction * (KNOCKBACK_FORCE+porcentaje)
			# comprobar si el knockback ha terminado
			if knockback_direction.length() < 10:
				is_knocked_back = false
		
		move_and_slide()	

 

@onready var timer: Timer = $Timer
@onready var ganador1 = $"../Ganador1"

func _on_areadaño_area_entered(area):
	if area.is_in_group("ataque"):
		$AnimatedSprite2D.play("hurt")
		lePegan= true
		#aplicar knockback
		knockback_direction = global_position-area.global_position
		knockback_direction = knockback_direction.normalized()
		is_knocked_back = true
		porcentaje += daño
	if area.is_in_group("muelte"):
		stock -= 1
		cambia_vida.emit(stock)
		is_knocked_back = false
		porcentaje = 0 
		if stock>0:
			tp()
			is_knocked_back = false
		else:
			timer.start(3)
			ganador1.show()
			pass

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "hurt":
		lePegan = false
		isAtacking = false
		$areaataque/colisionataque.disabled = true
	if $AnimatedSprite2D.animation == "ataque":
		$areaataque/colisionataque.disabled = true
		isAtacking = false
	if $AnimatedSprite2D.animation == "airatack":
		$areaataque/colisionataque.disabled = true
		isAtacking = false
func tp():
	global_position = posicion_inicialad
	set_physics_process(true)

func _on_timer_timeout():
	ganador1.hide()
	get_tree().change_scene_to_file("res://Escenas/main.tscn")
	pass # Replace with function body.
