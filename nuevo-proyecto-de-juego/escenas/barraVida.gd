extends HBoxContainer
#CORRECCION: El HBoxContainer que usas en todos los niveles, lo tenés que guardar en una escena para poder instanciarlo en lugar de copiarlo y pegarlo. O una movida mejor es ponerlo directamente dentro de la escena del jugador!

var jugador : CharacterBody2D = null
var cuadrados : Array = []

func _ready() -> void:
	jugador = get_tree().get_first_node_in_group("jugador")
	
	#CORRECCION: Acá también, justo abajo de lo del jugador teníamos la posibilidad de usar get_nodes_in_group(). Además, es cuadrados = get_children(), o tuviste algún problema usando eso?
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
			
			
	
		
	
