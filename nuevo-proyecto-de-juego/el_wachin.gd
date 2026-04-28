extends CharacterBody2D

@export var vida : int = 30
@export var danio : int = 5
@export var velocidad : float = 60.0
var jugador : CharacterBody2D = null
var atacando : bool = false
var reciboDanio : bool = false

func _physics_process(delta: float) -> void:
	
	if reciboDanio:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	if jugador:
		var distancia = global_position.distance_to(jugador.global_position)
		var direccion = (jugador.global_position - global_position).normalized()
		
		
		if distancia > 53:
			atacando = false
			velocity = direccion * velocidad
			$AnimatedSprite2D.play("enemy_walk")
		else:
			velocity = Vector2.ZERO
			if not atacando :
				atacar()
			
		
		
		if direccion.x > 0:
			$AnimatedSprite2D.flip_h = false
		elif direccion.x < 0:
			$AnimatedSprite2D.flip_h = true
		
	else:
		atacando = false
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("enemy_iddle")
	
	move_and_slide()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		jugador = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		jugador = null
		
		
		
func atacar() -> void:
	atacando = true
	$AnimatedSprite2D.play("enemy_attack") 
	await $AnimatedSprite2D.animation_finished
	if jugador :
		var distancia = global_position.distance_to(jugador.global_position)
		if distancia <= 53:
			jugador.recibir_danio(danio)
	atacando = false
	
func recibir_danio(cantidad : int) -> void:
	if reciboDanio:
		return
	reciboDanio = true
	vida -= cantidad
	print("vida del enemigo:", vida)
	$AnimatedSprite2D.play("enemy_hurt")
	if vida <= 0:
		queue_free()
		return
	$AnimatedSprite2D.play("enemy_hurt")
	await $AnimatedSprite2D.animation_finished
	reciboDanio = false
	

	
