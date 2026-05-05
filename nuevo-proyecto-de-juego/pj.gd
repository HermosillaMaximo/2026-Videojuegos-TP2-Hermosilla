extends CharacterBody2D

@export var vida : int
@export var vida_max : int = 100
@export var velocidad : float
@export var danio : int
var atacando : bool = false
var recibeDanio : bool = false
var enemigos_en_rango : Array = []


func  _ready() -> void:
	vida = vida_max
	



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
	
	
	if recibeDanio:
		return
	# esto me ayudo para que el personaje no se quede statico cuando recibe el golpe
	
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
	for enemigo in enemigos_en_rango:
		if is_instance_valid(enemigo):
			var posicion_jugador = global_position
			var posicion_enemigo = enemigo.global_position
			var distancia = posicion_jugador.distance_to(posicion_enemigo)
			if distancia <= 100:
				enemigo.recibir_danio(danio)
	atacando = false
	
func recibir_danio(cantidad : int) -> void:
	if recibeDanio:
		return
	vida -= cantidad
	print("vida del jugador:", vida)
	if vida <= 0:
		get_tree().change_scene_to_file("res://escenas/GameOver/game_over.tscn")
		return
	recibeDanio = true
	$AnimatedSprite2D.play("player_hurt")
	await $AnimatedSprite2D.animation_finished
	recibeDanio = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemigo"):
		enemigos_en_rango.append(body)
		
func _on_area_2d_body_exited(body : Node2D) -> void:
	if body.is_in_group("enemigo"):
		enemigos_en_rango.erase(body)
