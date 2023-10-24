class_name SectorMeteoritos
extends Node2D

## Atributos Export
export var cantidad_meteoritos:int = 10
export var intervalo_spawn:float = 1.2

# Atributos
var spawners:Array

## Metodos
func _ready() -> void:
	almacenar_spawners()
	$SpawnTimer.wait_time = intervalo_spawn
## Constructor
func crear(pos:Vector2, meteoritos:int) -> void:
	global_position = pos
	cantidad_meteoritos = meteoritos
	
## Metodos Custom
func conectar_seniales_detectores() -> void:
	for detector in $DetectorFueraZona.get_children():
		detector.connect("body_entered", self)

func almacenar_spawners() -> void:
	for spawner in $Spawners.get_children():
		spawners.append(spawner)
		
func spawner_aleatorio() -> int:
	randomize()
	return randi() % spawners.size()


## Señales internas
func _on_detector_body_entered(body: Node) -> void:
	body.set_esta_en_sector(false)
#func _on_Timer_timeout() -> void:
#	for spawner in $Spawners.get_children():
#		spawner.spawnear_meteorito()


func _on_SpawnTimer_timeout() -> void:
	if cantidad_meteoritos == 0:
		$SpawnTimer.stop()
		return
	spawners[spawner_aleatorio()].spawnear_meteorito()
	cantidad_meteoritos -= 1
		