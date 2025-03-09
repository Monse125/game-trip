extends CharacterBody2D

# Variables de configuración
var velocidad = 200.0  # Velocidad de movimiento
var is_sleep = false  # Estado para permitir movimiento

# Referencia al sprite (opcional)
@onready var sprite: Sprite2D = $Sprite2D

func _process(delta):
	if is_sleep:
	
		var direccion = Vector2.ZERO  # Vector para la dirección del movimiento

		# Detectar las teclas WASD
		if Input.is_action_pressed("ui_up") or Input.is_action_pressed("up"):
			direccion.y -= 1
		if Input.is_action_pressed("ui_down") or Input.is_action_pressed("down"):
			direccion.y += 1
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("left"):
			direccion.x -= 1
		if Input.is_action_pressed("ui_right") or Input.is_action_pressed("right"):
			direccion.x += 1

		# Normalizar para velocidad constante en diagonal
		if direccion != Vector2.ZERO:
			direccion = direccion.normalized()

		# Mover al personaje
		velocity = direccion * velocidad
		
	else:
		velocity = Vector2.ZERO
	move_and_slide()
