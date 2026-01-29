extends Node

@export var player: Player
@export var reach: float = 32.0
@export var state_chart: StateChart
@export var anim_player: AnimationPlayer
@export var ray_cast_2d: RayCast2D

var pickaxe_damage: int = 7
var pickaxe_strength: int = GlobalEnums.ROCK_STRENGTHS.SOFT

func _on_mining_state_state_entered() -> void:
	pass

func _on_mining_state_state_input(event: InputEvent) -> void:
	if event.is_action_pressed("action_swing"):
		mine()
	if event.is_action_pressed("action_throw_tool"):
		state_chart.send_event("_transition_throwing")

func _on_mining_state_state_exited() -> void:
	pass

func mine() -> void:
	var start: Vector2 = player.global_position
	var dir: Vector2 = (start - player.get_global_mouse_position()).normalized()
	var end: Vector2 = -dir * reach
	
	ray_cast_2d.global_position = start
	ray_cast_2d.target_position = end
	ray_cast_2d.hit_from_inside = false
	ray_cast_2d.force_raycast_update()
	
	if not ray_cast_2d.is_colliding():
		return
	
	if ray_cast_2d.get_collider() is SellStation:
		ray_cast_2d.get_collider().sell_ores(self)
	_try_mine_object(ray_cast_2d.get_collision_point(), ray_cast_2d.get_collision_normal())

func _try_mine_object(raycast_result: Vector2, normal: Vector2) -> void:
	var ore: Ore = player.world.cave.mine(raycast_result, normal, pickaxe_damage, pickaxe_strength)
	
	if not ore:
		return
	
	player.inventory.put_in_inventory(ore, 1)
