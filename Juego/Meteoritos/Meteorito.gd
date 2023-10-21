class_name Meteorito
extends RigidBody2D

## Atributos Export
export var vel_lineal_base:Vector2 = Vector2(300.0, 300.0)
export var vel_ang_base:float = 3.0
export var hitpoints_base:float = 10.0

# Atributos
var hitpoints:float

onready var impacto_sfx:AudioStreamPlayer2D = $ImpactoSFX
onready var animacion_impacto:AnimationPlayer = $AnimationPlayer

## Metodos
func _ready() -> void:	
	angular_velocity = vel_ang_base
	
## Metodos Custom
func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0:
		destruir()
	animacion_impacto.play("impacto")
	impacto_sfx.play()
	
func destruir() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	Eventos.emit_signal("meteorito_destruido", global_position)
	queue_free()
	
	
##Constructor
func crear(pos: Vector2, dir: Vector2, tamanio:float) -> void:
	position = pos
	mass *= tamanio
	$Sprite.scale = Vector2.ONE * tamanio
	var radio:int = int($Sprite.texture.get_size().x / 2.3 * tamanio)
	var forma_colision:CircleShape2D = CircleShape2D.new()
	forma_colision.radius = radio
	$CollisionShape2D.shape = forma_colision
	linear_velocity = (vel_lineal_base * dir / tamanio) * aleatorizar_velocidad()
	angular_velocity = (vel_ang_base / tamanio) * aleatorizar_velocidad()
	hitpoints = hitpoints_base * tamanio
	print("Hitpoints: ", hitpoints)
	
## Metodos Custom
func aleatorizar_velocidad() -> float:
	randomize()
	return rand_range(1.1, 1.4)

