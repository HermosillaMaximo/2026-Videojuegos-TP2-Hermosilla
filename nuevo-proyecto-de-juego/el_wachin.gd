extends CharacterBody2D

@export var vida : int = 30
@export var danio : int = 5
@export var velocidad : float = 60.0


var jugador : CharacterBody2D = null

func _physics_process(delta: float) -> void:
	if jugador:
		var direccion = (jugador.global_position - global_position).normalized()
		velocity = direccion * velocidad
		
		if direccion.x > 0:
			$AnimatedSprite2D.flip_h = false
		elif direccion.x < 0:
			$AnimatedSprite2D.flip_h = true
		
		$AnimatedSprite2D.play("enemy_run")
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("enemy_iddle")
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		jugador = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		jugador = null
		
		
		
