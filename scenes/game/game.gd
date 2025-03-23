extends Node2D

@onready var balanceo: Node2D = $balanceo
@onready var tiempo: Node2D = $Tiempo
@onready var pantalla_negra: ColorRect = $PantallaNegra
@onready var bullet_hell: Node2D = $BulletHell


var is_falling_asleep = false  # Estado de "quedándose dormido"
var fall_asleep_timer = 4.0  # Segundos para dormirse por completo
var fade_start_time = 3.0  # A partir de 3 segundos empieza el fade

func _ready():
	# Conectar la señal balance_changed a una función local
	balanceo.connect("balance_changed", Callable(self, "_on_balance_changed"))
	pantalla_negra.modulate.a = 0  # Ocultar la pantalla negra al inicio
	bullet_hell.visible = false

func _process(delta):
	if is_falling_asleep:
		fall_asleep_timer -= delta

		# A partir de los 3 segundos, empieza a oscurecer la pantalla
		if fall_asleep_timer <= fade_start_time:
			var fade_progress = (fade_start_time - fall_asleep_timer) / (fade_start_time - 0.0)
			pantalla_negra.modulate.a = clamp(fade_progress, 0, 1)

		# Si pasaron 6 segundos, activar el sueño
		if fall_asleep_timer <= 0:
			activar_sueno()

func _on_balance_changed(is_balanced: bool):
	if is_balanced:
		iniciar_quedarse_dormido()
	else:
		despertar()

func iniciar_quedarse_dormido():
	is_falling_asleep = true
	fall_asleep_timer = 6.0  # Reiniciar el contador

func activar_sueno():
	is_falling_asleep = false
	tiempo.is_sleep = true
	bullet_hell.activate_sleep()
	pantalla_negra.modulate.a = 1  # Hacer la pantalla negra completamente visible

func despertar():
	is_falling_asleep = false
	tiempo.is_sleep = false
	bullet_hell.desactivate_sleep()
	pantalla_negra.modulate.a = 0  # Ocultar la pantalla negra
