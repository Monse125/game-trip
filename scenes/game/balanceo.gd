extends Node2D

# Variables de configuración
var max_angulo = 60.0  # Ángulo máximo a la izquierda y derecha
var velocidad_base = 500.0  # Velocidad de rotación (grados por segundo)
var distancia_maxima = 100.0  # Distancia máxima desde el centro que afecta la velocidad
var is_balanced = false  # Bool que indica si la imagen está balanceada
var angulo_balanced = 20.0

# Señal para notificar cambios en is_balanced
signal balance_changed(is_balanced: bool)

# Estado actual
var angulo_actual: float = 0.0  # Ángulo de la imagen
var direccion_rotacion: int = 0  # Dirección de rotación: -1 = izquierda, 1 = derecha

@onready var imagen: Sprite2D = $test


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Centrar el punto de pivote de la imagen
	imagen.centered = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)


func _input(event):
	# Detectar movimiento horizontal del mouse
	if event is InputEventMouseMotion:
		# Obtener la posición del mouse
		var mouse_pos = event.position.x

		# Determinar la mitad de la pantalla
		var mitad_pantalla = get_viewport().size.x / 2
		direccion_rotacion = -1 if mouse_pos < mitad_pantalla else 1


func _process(delta):
	# Obtener la distancia del mouse al centro de la pantalla
	var mouse_pos = get_viewport().get_mouse_position().x
	var mitad_pantalla = get_viewport().size.x / 2
	var distancia = abs(mouse_pos - mitad_pantalla)

	# Ajustar la velocidad en función de la distancia
	var velocidad_rotacion = velocidad_base * (distancia / distancia_maxima)

	# Rotar la imagen dependiendo de la dirección
	if direccion_rotacion == -1 and angulo_actual > -max_angulo:
		# Si el mouse está a la izquierda y no hemos llegado al límite de la izquierda
		angulo_actual -= velocidad_rotacion * delta
		angulo_actual = max(angulo_actual, -max_angulo)  # Limitar el ángulo mínimo
	elif direccion_rotacion == 1 and angulo_actual < max_angulo:
		# Si el mouse está a la derecha y no hemos llegado al límite de la derecha
		angulo_actual += velocidad_rotacion * delta
		angulo_actual = min(angulo_actual, max_angulo)  # Limitar el ángulo máximo

	# Aplicar la rotación a la imagen
	imagen.rotation_degrees = angulo_actual
	
	# Actualizar el estado de is_balanced
	var estaba_balanceado = is_balanced
	is_balanced = angulo_actual > -angulo_balanced and angulo_actual < angulo_balanced

	# Emitir señal si el estado cambia
	if is_balanced != estaba_balanceado:
		emit_signal("balance_changed", is_balanced)

	# Cambiar color según estado
	imagen.modulate = Color(1, 0, 0) if is_balanced else Color(0, 0, 1)
