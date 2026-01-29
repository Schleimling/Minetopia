extends CharacterBody2D
class_name Player

@onready var world: World = $".."

@export_flags_2d_physics var SWING_COLLISION: int = 0x1

@onready var inventory: Inventory = $Inventory

@onready var ray_cast_2d: RayCast2D = $RayCast2D



var swinging: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("action_swing"):
			pass
		if event.is_action_pressed("action_throw_tool"):
			pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "swing":
		swinging = false
