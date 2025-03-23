extends Node2D

@onready var mono: CharacterBody2D = $Mono

func activate_sleep() -> void:
	mono.is_sleep = true
	visible = true
	
func desactivate_sleep() -> void:
	mono.is_sleep = false
	visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
