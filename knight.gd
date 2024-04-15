extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction == +1:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
	elif direction == -1:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
		
	if not is_on_floor():
		$AnimatedSprite2D.play("fall")
		velocity.y += gravity * delta
		if velocity.y < 1:
			$AnimatedSprite2D.play("jump")
		
	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		$AnimatedSprite2D.play("jump")
		velocity.y = JUMP_VELOCITY
		
	move_and_slide()
