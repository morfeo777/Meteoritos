class_name Proyectil
extends Area2D

## Atributos
var velocidad:Vector2 = Vector2.ZERO
var danio:float

## Metodos
func crear(pos: Vector2, dir: float, vel:float, danio_p: int) -> void:
	position = pos
	rotation = dir
	velocidad = Vector2(vel, 0).rotated(dir)
	danio = danio_p

func _physics_process(delta: float) -> void:
	position += velocidad * delta

##Metodos Custom
func daniar(otro_cuerpo: CollisionObject2D) -> void:
	print(otro_cuerpo.name)
	print(otro_cuerpo.owner.name)
	if otro_cuerpo.has_method("recibir_danio"):
		otro_cuerpo.recibir_danio(danio)
	queue_free()
	
##Señales Internas
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Proyectil_area_entered(area: Area2D) -> void:
	#if area.has_method("recibir_danio"):
	#	area.recibir_danio()
	#queue_free()
	daniar(area)



func _on_Proyectil_body_entered(body: Node) -> void:
	daniar(body)
