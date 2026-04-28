extends Node2D


@export var escena_enemigo : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawns = [$"Spawn 1",$"Spawn 2",$"Spawn 3",$"Spawn 4",$"Spawn 5",$"Spawn 6",$"Spawn 7"]
	for spawn in spawns:
		var enemigo =  escena_enemigo.instantiate()
		enemigo.global_position = spawn.global_position
		add_child(enemigo)
