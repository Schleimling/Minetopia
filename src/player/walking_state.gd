extends Node

@export var SPEED: float = 64.0
@export var JUMP_VELOCITY: float = -200.0
@export var player: Player
@export var state_chart: StateChart
@export var anim_player: AnimationPlayer

func _on_walking_atomic_state_state_entered() -> void:
	anim_player.play("walk")


func _on_walking_atomic_state_state_exited() -> void:
	anim_player.play("RESET")


func _on_walking_atomic_state_state_input(event: InputEvent) -> void:
	pass # Replace with function body.


func _on_walking_atomic_state_state_physics_processing(delta: float) -> void:
	var velocity: Vector2 = player.velocity
	if not player.is_on_floor():
		velocity += (player.get_gravity() / 2) * delta

	# Handle jump.
	if Input.is_action_pressed("movement_jump") and player.is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("movement_left", "movement_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if player.velocity == Vector2.ZERO:
		state_chart.send_event("_transition_to_idle")
	
	player.velocity = velocity
	player.move_and_slide()
