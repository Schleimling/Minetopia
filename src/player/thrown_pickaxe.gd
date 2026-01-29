extends CharacterBody2D
class_name ThrownPickaxe

signal colliding

var rotation_speed: float = 12.0
var travel_direction: Vector2
@onready var sprite_2d: Sprite2D = $Sprite2D

var SPEED: float = 32.0

var initial_velocity: Vector2

var rope: Node2D
	
func _physics_process(delta: float) -> void:
	sprite_2d.rotate(deg_to_rad(rotation_speed))
	
	velocity = initial_velocity
	
	initial_velocity += (travel_direction * SPEED) * delta
	
	initial_velocity.y += ((get_gravity().y / 2) * delta)
	
	if move_and_slide():
		colliding.emit()
	
