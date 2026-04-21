extends CharacterBody2D

@export var vida : int
@export var velocidad : float
@export var danio : int


func _physics_process(delta: float) -> void:
	var direccion := Vector2.ZERO 
	direccion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direccion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direccion = direccion.normalized()  
	velocity = direccion * velocidad
	move_and_slide()
	
	if direccion != Vector2.ZERO:
		$AnimatedSprite2D.play("player_run")
	else :
		$AnimatedSprite2D.play("player_idle")
		
		
	if direccion.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif direccion.x < 0:
		$AnimatedSprite2D.flip_h = true
	
	
