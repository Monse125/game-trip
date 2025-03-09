extends Node2D


# Variables
var is_sleep = false
var time_elapsed = 0.0  # Tiempo acumulado

# Referencias a nodos
@onready var reloj: Label = $Reloj
@onready var timer: Timer = $Timer


func _ready():
	# Conectar la señal del Timer para actualizar el tiempo
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))

# Manejando el click para dormir
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			is_sleep = true  # Si presionas, modo dormido
		else:
			is_sleep = false  # Si sueltas, modo normal

# Función para el Timer
func _on_Timer_timeout():
	# Si estás dormido, el tiempo corre al doble
	if is_sleep:
		time_elapsed += 0.5  # Aumenta el doble (0.2 en vez de 0.1)
	else:
		time_elapsed += 0.1  # Aumento normal

	# Actualiza el texto del reloj (con dos decimales)
	reloj.text = "Tiempo: %.2f" % time_elapsed
