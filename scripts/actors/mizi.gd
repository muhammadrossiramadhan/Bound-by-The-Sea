extends CharacterBody2D

@export var mizi_speed : float = 500
# It's better to get the direction inside the process loop
var mizi_direction : Vector2

func _physics_process(_delta: float) -> void:
	# 1. Get the input direction as a single vector (normalized)
	mizi_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. Handle Sprite Flipping (Horizontal)
	if mizi_direction.x < 0: 
		%AnimatedSprite2D.flip_h = false
	elif mizi_direction.x > 0: 
		%AnimatedSprite2D.flip_h = true
	
	# 3. Handle Animations (Logic for Up/Down vs Side)
	if mizi_direction.x != 0:
		%AnimatedSprite2D.play("side")
	elif mizi_direction.y > 0:
		%AnimatedSprite2D.play("running")
	elif mizi_direction.y < 0:
		%AnimatedSprite2D.play("back")
	else:
		%AnimatedSprite2D.play("idle")

	# 4. Movement Logic
	if mizi_direction != Vector2.ZERO:
		velocity = mizi_direction * mizi_speed
	else:
		# Smoothly stop when no keys are pressed
		velocity = velocity.move_toward(Vector2.ZERO,50)
			
	move_and_slide()
