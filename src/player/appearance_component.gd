extends Node

@export var player: Player
@export var body: Node2D
@export var player_sprite: Sprite2D
@export var arm_privot: Node2D
@export var pickaxe: Sprite2D
@export var arm_sprite: Sprite2D
@export var arm_point: Node2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	var global_mouse_pos: Vector2 = player.get_global_mouse_position()
	
	pickaxe.global_position = arm_point.global_position
	
	arm_privot.look_at(global_mouse_pos)
	
	var mouse_direction: Vector2 = (player.global_position - global_mouse_pos).normalized()
	
	if mouse_direction.x < 0.0:
		body.scale = Vector2(1.0, 1.0)
	else:
		body.scale = Vector2(-1.0, 1.0)
