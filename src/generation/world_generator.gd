extends Node2D

@export var StoneLayer: TileMapLayer
@export var HardStoneLayer: TileMapLayer
@export var VolcanicLayer: TileMapLayer

var world_size: Vector2i = Vector2i(64, 1200)

var rocks: Dictionary

const ORES_DICTIONARY = preload("res://src/generation/ores.json")

func _ready() -> void:
	generate_world(world_size)

func generate_world(size: Vector2, rock_positions: Dictionary = {}):
	
	if not rock_positions.is_empty():
		_load_world(size, rock_positions)
		return
	
	rocks = {}
	
	for x in size.x:
		for y in size.y:
			var current_number: int = x+y
			
			rocks.merge({current_number: _get_random_rock(Vector2(x, y))})

func _load_world(size: Vector2, rock_positions: Dictionary):
	pass

func _get_random_rock(position: Vector2) -> int:
	var random_rock_id: int = 0
	
	
	
	return random_rock_id
