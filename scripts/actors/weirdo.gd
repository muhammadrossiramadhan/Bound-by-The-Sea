extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	
	%AnimatedSprite2D.play("idle")

	move_and_slide()
