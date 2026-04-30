extends HBoxContainer

var jugador : CharacterBody2D = null
var cuadrados : Array = []

func _ready() -> void:
	jugador = get_tree().get_first_node_in_group("jugador")
	for hijo in get_children():
		cuadrados.append(hijo)
		
func _process(delta: float) -> void:
	if jugador == null:
		return
	var vidaActual = jugador.vida
	var vidaPorCuadrado = jugador.vida_max / cuadrados.size()
	
	
	for i in cuadrados.size():
		if vidaActual > i * vidaPorCuadrado:
			cuadrados[i].visible = true
		else:
			cuadrados[i].visible = false
			
			
	
		
	
