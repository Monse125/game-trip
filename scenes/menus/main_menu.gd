extends Control

@onready var button_start: Button = %ButtonStart
@onready var button_settings: Button = %ButtonSettings
@onready var button_exit: Button = %ButtonExit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_start.pressed.connect(_on_start_pressed)
	button_settings.pressed.connect(_on_settings_pressed)
	button_exit.pressed.connect(_on_exit_pressed)

func _on_start_pressed():
	pass
	
func _on_settings_pressed():
	pass
	
func _on_exit_pressed():
	get_tree().quit()
