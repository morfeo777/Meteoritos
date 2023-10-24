class_name MeteoritoSpawner
extends Position2D

export var direccion:Vector2 = Vector2(1, 1)
export var rango_tamanio_meteorito:Vector2 = Vector2(0.5, 2.2)


#func _ready() -> void:
#	yield(owner, "ready")
#	spawnear_meteorito()
	
func spawnear_meteorito() -> void:
	var alea_dir:float = aleatorizar_direccion()
	print(alea_dir * direccion)
	Eventos.emit_signal("spawn_meteorito", 
	global_position, 
	direccion * alea_dir,
	tamanio_meteorito_aleatorio())
	
func tamanio_meteorito_aleatorio() -> float:
	randomize()
	return rand_range(rango_tamanio_meteorito[0], rango_tamanio_meteorito[1])
	
func aleatorizar_direccion() -> float:
	randomize()
	return rand_range(2.5, -2.5)
	#return 1 if random.random() < 0.5 else -1
	#return [-1,1][rand_range(2)]
