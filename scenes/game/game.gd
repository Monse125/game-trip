extends Node2D

@onready var balanceo: Node2D = $balanceo
@onready var tiempo: Node2D = $Tiempo
@onready var mono: CharacterBody2D = $Mono

func _ready():
	# Conectar la señal balance_changed a una función local
	balanceo.connect("balance_changed", Callable(self, "_on_balance_changed"))

# Función que se activa cuando cambia el balance
func _on_balance_changed(is_balanced: bool):
	# Sincronizar is_sleep con is_balanced
	tiempo.is_sleep = is_balanced
	mono.is_sleep = is_balanced
