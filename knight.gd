extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isAtacking= false
var lePegan = false
var dobleSalto = false

func _physics_process(delta):
	# Add the gravity
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction == +1 and isAtacking == false and lePegan == false:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = false
		get_node("areaataque").set_scale(Vector2(1, 1))
		$AnimatedSprite2D.play("run")
	elif direction == -1 and isAtacking == false and lePegan == false:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = true
		get_node("areaataque").set_scale(Vector2(-1, 1))
		$AnimatedSprite2D.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if isAtacking == false and lePegan == false:
			$AnimatedSprite2D.play("idle")
		
	if not is_on_floor():
		$AnimatedSprite2D.play("fall")
		velocity.y += gravity * delta
		isAtacking = false
		$areaataque/colisionataque.disabled = true
		if lePegan == true:
			lePegan = false
		if Input.is_action_just_pressed("up") and dobleSalto == false:
			velocity.y = JUMP_VELOCITY
			dobleSalto = true
	if is_on_floor():
		dobleSalto = false

		
	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor() and isAtacking ==false and lePegan == false:
		$AnimatedSprite2D.play("jump")
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("attackp1") and is_on_floor() and lePegan == false:
		isAtacking= true
		$areaataque/colisionataque.disabled = false
		$AnimatedSprite2D.play("ataque")
		
	if is_on_floor() and Input.is_action_pressed("pause"):
		position.y -=3
	if is_on_floor() and Input.is_action_pressed("ui_down"):
		position.y +=3
		
	move_and_slide()



func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "hurt":
		lePegan = false
		isAtacking = false
		$areaataque/colisionataque.disabled = true
	if $AnimatedSprite2D.animation == "ataque":
		$areaataque/colisionataque.disabled = true
		isAtacking = false


func _on_areadaño_area_entered(area):
	if area.is_in_group("ataquep2"):
		$AnimatedSprite2D.play("hurt")
		lePegan = true
		print("si pego")

