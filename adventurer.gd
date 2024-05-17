extends CharacterBody2D

const KNOCKBACK_FORCE = 500 
const SPEED = 250.0
const JUMP_VELOCITY = -600.0

var porcentaje = 0
var peso = 100
var daño = 15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isAtacking = false
var lePegan = false
var dobleSalto = false
var knockback_direction = Vector2.ZERO
var is_knocked_back = false

func _physics_process(delta):
	# Add the gravity

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
		knockback_direction *= 5
		#añadir la fuerza del knockback a la velocidad
		velocity += knockback_direction * (KNOCKBACK_FORCE+porcentaje)
		# comprobar si el knockback ha terminado
		print(KNOCKBACK_FORCE)
		if knockback_direction.length() < 10:
			is_knocked_back = false
	move_and_slide()	

func _on_areadaño_area_entered(area):
		if area.is_in_group("ataque"):
			$AnimatedSprite2D.play("hurt")
			lePegan= true
			#aplicar knockback
			knockback_direction = global_position-area.global_position
			knockback_direction = knockback_direction.normalized()
			is_knocked_back = true
			porcentaje += daño


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

func knockback(force: float, x_pos : float, up_force : float):
	if x_pos < global_position.x :
		velocity = Vector2(force * 2, -force * up_force)
	else:
		velocity = Vector2(-force * 2, -force * up_force)


