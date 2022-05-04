extends MarginContainer

onready var start = $TextureRect/PanelContainer/VBoxContainer/Start
onready var exit = $TextureRect/PanelContainer/VBoxContainer/Exit

func _ready():
	start.connect("pressed", self, "_on_start_pressed" )
	exit.connect("pressed", self, "_on_exit_pressed")

func _on_start_pressed():
	get_tree().change_scene("res://Scenes/level.tscn")

func _on_exit_pressed():
	get_tree().quit()
