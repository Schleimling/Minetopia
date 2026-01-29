extends Node

@export var player: Player
@export var state_chart: StateChart

func _on_idle_atomic_state_state_entered() -> void:
	pass # Replace with function body.


func _on_idle_atomic_state_state_exited() -> void:
	pass # Replace with function body.


func _on_idle_atomic_state_state_physics_processing(delta: float) -> void:	
	if not player.is_on_floor():
		player.velocity += (player.get_gravity() / 2) * delta
	player.move_and_slide()
	if Input.is_action_pressed("movement_left"):
		state_chart.send_event("_transition_to_walking")
	if Input.is_action_pressed("movement_right"):
		state_chart.send_event("_transition_to_walking")
	if Input.is_action_just_pressed("movement_jump"):
		state_chart.send_event("_transition_to_walking")
