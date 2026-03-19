extends CharacterBody2D

const FPS_MULTIPLIER : float = 0.8

@export var mizi_speed : float = 500.0
var mizi_direction : Vector2
var last_anim : String = "front_idle"

func _physics_process(_delta: float) -> void:
	%AnimatedSprite2D.speed_scale = FPS_MULTIPLIER
	mizi_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if mizi_direction.x < 0: 
		%AnimatedSprite2D.flip_h = false
	elif mizi_direction.x > 0: 
		%AnimatedSprite2D.flip_h = true
	
	if mizi_direction != Vector2.ZERO:
		velocity = mizi_direction * mizi_speed
		if mizi_direction.x != 0:
			%AnimatedSprite2D.play("side_walk")
			last_anim = "side_idle"
		elif mizi_direction.y > 0:
			%AnimatedSprite2D.play("front_walk")
			last_anim = "front_idle"
		elif mizi_direction.y < 0:
			%AnimatedSprite2D.play("back_walk")
			last_anim = "back_idle"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, 40)
		%AnimatedSprite2D.play(last_anim)
			
	move_and_slide()
