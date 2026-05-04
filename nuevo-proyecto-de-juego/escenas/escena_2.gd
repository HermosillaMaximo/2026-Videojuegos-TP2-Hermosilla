extends Node2D

@export var escena_corazon : PackedScene
@export var escena_enemigo2 : PackedScene
var timer_corazon : float = 0.0
@export var timpoCorazon : float = 15.0
var corazonesActivos : int = 1


func _process(delta: float) -> void:
	timer_corazon += delta
	if timer_corazon >= timpoCorazon:
		timer_corazon = 0.0
		if corazonesActivos == 0:
			spawnearCorazon()
		elif corazonesActivos >= 1:
			await get_tree().create_timer(5.0).timeout
			spawnearCorazon()
			
		
	var enemigosTotalesBROTHER = get_tree().get_nodes_in_group("enemigo")
	if enemigosTotalesBROTHER.size() == 0:
		get_tree().change_scene_to_file("res://escenas/escena_2.tscn")


func spawnearCorazon() -> void:
	var spawns = [$SpawnCorazon1,$SpawnCorazon2,$SpawnCorazon3]
	var spawnerRandon = spawns[randi() % spawns.size()]
	var corazon = escena_corazon.instantiate()
	corazon.global_position = spawnerRandon.global_position
	add_child(corazon)
	corazonesActivos += 1

	
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawns = [$"Spawn 1",$"Spawn 2",$"Spawn 3",$"Spawn 4",$"Spawn 5",$"Spawn 6",$"Spawn 7",$"Spawn 8",$"Spawn 9",$"Spawn 10"]
	for spawn in spawns:
		var enemigo =  escena_enemigo2.instantiate()
		enemigo.global_position = spawn.global_position
		add_child(enemigo)
	
	
