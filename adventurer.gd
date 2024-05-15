extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isAtacking = false
var lePegan = false
var dobleSalto = false
var knockbackdir = Vector2()
var knocbackwait = 16

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

	if is_on_floor() and Input.is_action_pressed("pausa"):
		position.y -=3
	if is_on_floor() and Input.is_action_pressed("ui_down"):
		position.y +=3
	move_and_slide()	

func _on_areadaño_area_entered(area):
		if area.is_in_group("ataque"):
			$AnimatedSprite2D.play("hurt")
			lePegan= true
			


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


