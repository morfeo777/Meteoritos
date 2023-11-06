class_name EnemigoInterceptor
extends EnemigoBase
#extends "res://Juego/Enemigos/EnemigoBase.gd"

enum ESTADO_IA {IDLE, ATACANDOQ, ATACANDOP, PERSECUCION}

#Atributos Export
export var potencia_max:float = 800.0


#Atributos
var estado_ia_actual:int = ESTADO_IA.IDLE
var potencia_actual:float = 0.0

#Metodos
func _ready() -> void:
	#(estado_ia_actual)
	if estado_ia_actual == ESTADO_IA.IDLE:
		print("Estoy en IDLE al comienzo")
		
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	linear_velocity += dir_player.normalized() * potencia_actual * state.get_step()
	
	linear_velocity.x = clamp(linear_velocity.x, -potencia_max, potencia_max)
	linear_velocity.y = clamp(linear_velocity.y, -potencia_max, potencia_max)

#Metodos Custom
func controlador_estados_ia(nuevo_estado: int) -> void:
	match nuevo_estado:
		ESTADO_IA.IDLE:
			canion.set_esta_disparando(false)
			potencia_actual = 0.0
			print("Estado: IDLE - Canion Apagado")
		ESTADO_IA.ATACANDOQ:
			canion.set_esta_disparando(true)
			potencia_actual = 0.0
			print("Estado: ATACANDOQ - Canion Disparando")
		ESTADO_IA.ATACANDOP:
			canion.set_esta_disparando(true)
			potencia_actual = potencia_max
			print("Estado: ATACANDOP - Canion Disparando")
		ESTADO_IA.PERSECUCION:
			canion.set_esta_disparando(false)
			potencia_actual = potencia_max
			print("Estado: PERSECUCION - Canion Apagado")
		_:
			print("Error de Estado")
	
	estado_ia_actual = nuevo_estado






func _on_AreaDisparo_body_entered(body: Node) -> void:
	print("Entro al AreaDisparo")
	controlador_estados_ia(ESTADO_IA.ATACANDOP)		

func _on_AreaDisparo_body_exited(body: Node) -> void:
	print("Salio AreaDisparo")
	controlador_estados_ia(ESTADO_IA.PERSECUCION)	

func _on_AreaDeteccion_body_entered(body: Node) -> void:
	print("Entro AreaDeteccion")
	controlador_estados_ia(ESTADO_IA.ATACANDOQ)	

func _on_AreaDeteccion_body_exited(body: Node) -> void:
	print("Salio AreaDeteccion")
	controlador_estados_ia(ESTADO_IA.ATACANDOP)	
