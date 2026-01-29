extends Node

@export var SPEED: float = 64.0
@export var throw_strength: float = -400.0
@export var player: Player
@export var state_chart: StateChart
@export var anim_player: AnimationPlayer
@export var pickaxe: Sprite2D

var thrown_pickaxe: ThrownPickaxe
const THROWN_PICKAXE = preload("uid://eqx5k0i73s7u")

const ROPE = preload("uid://76qvfxwdfshb")

func _on_throw_atomic_state_state_entered() -> void:
	spawn_flying_pickaxe(player.global_position)

func spawn_flying_pickaxe(position: Vector2) -> void:
	
	thrown_pickaxe = THROWN_PICKAXE.instantiate()
	thrown_pickaxe.travel_direction = (position - player.get_global_mouse_position()).normalized()
	thrown_pickaxe.initial_velocity = thrown_pickaxe.travel_direction * throw_strength
	thrown_pickaxe.colliding.connect(flying_pickaxe_colliding)
	add_child(thrown_pickaxe)
	thrown_pickaxe.global_position = position + Vector2(0.0, -8.0)
	pickaxe.hide()
	thrown_pickaxe.sprite_2d.texture = pickaxe.texture
	
	return
	
	var new_rope: Node2D = ROPE.instantiate()
	add_child(new_rope)
	new_rope.global_position = player.global_position
	thrown_pickaxe.rope = new_rope
	
	new_rope.holder = player
	new_rope.target = thrown_pickaxe
	
	new_rope.generate_rope(16)
	

func flying_pickaxe_colliding() -> void:
	
	player.global_position = thrown_pickaxe.global_position + Vector2(0, 4.0)
	
	thrown_pickaxe.colliding.disconnect(flying_pickaxe_colliding)
	if thrown_pickaxe.rope:
		thrown_pickaxe.rope.queue_free()
	thrown_pickaxe.queue_free()
	pickaxe.show()
	state_chart.send_event("_transition_grapple")
