extends Node2D
class_name World

@onready var cave: Cave = $Cave

func _ready() -> void:
	$Cave.generate_cave(Vector2i(256, 1300))
