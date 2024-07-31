class_name Main extends Node

const EventHandler = preload("res://Scripts/eventhandler.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventHandler.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
