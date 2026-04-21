extends CharacterBody2D

@export var vida : int
@export var velocidad : float
@export var danio : int
var atacando : bool = false



func _physics_process(delta: float) -> void:
	if atacando:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	
	
	
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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("atacar") and not atacando:
		iniciar_ataque("player_attack")
	elif event.is_action_pressed("atacar2") and not atacando:
		iniciar_ataque("player_attack2")
		
	

func iniciar_ataque(animacion : String) -> void:
	atacando = true
	$AnimatedSprite2D.play(animacion)
	await $AnimatedSprite2D.animation_finished
	atacando = false
	
