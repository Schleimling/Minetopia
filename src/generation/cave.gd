extends Node2D
class_name Cave

@onready var stone_layer: TileMapLayer = $StoneLayer

var ore_dictionary: Dictionary

const BREAKING_ANIMATION = preload("uid://cv8glumeo6v5e")

##substract normal of tile collided from the position to get center of tile

func _ready() -> void:
	pass

func mine(raycast_result: Vector2, normal: Vector2, pickaxe_damage: float, pickaxe_strength: int) -> Ore:
	var cell_location: Vector2i = stone_layer.local_to_map(stone_layer.to_local(raycast_result - normal))
	var id: int = stone_layer.get_cell_source_id(cell_location)
	var data: TileData = stone_layer.get_cell_tile_data(cell_location)
	var ore_texture_origin: Vector2i = stone_layer.get_cell_atlas_coords(cell_location)
	
	for ore_name: String in GlobalEnums.ORES.data:
		ore_name = ore_name.to_lower()
		var ore_data: Dictionary = GlobalEnums.ORES.data.get(ore_name)
		var texture_origin: Vector2i = Vector2i(ore_data["texture_origin"]["x"], ore_data["texture_origin"]["y"])
		if texture_origin == ore_texture_origin:
			
			if ore_dictionary.get(cell_location).try_damage(pickaxe_damage, pickaxe_strength):
				var ore: Ore = ore_dictionary.get(cell_location)
				ore_dictionary.erase(cell_location)
				stone_layer.set_cell(cell_location, -1)
				return ore
			else:
				var ore: Ore = ore_dictionary.get(cell_location)
				if ore.breaking_anim:
					return
				ore.breaking_anim = BREAKING_ANIMATION.instantiate()
				ore.breaking_anim.current_stage = 4
				ore.breaking_anim.frame = ore.breaking_anim.current_stage - 1
				add_child(ore.breaking_anim)
				ore.breaking_anim.top_level = true
				ore.breaking_anim.global_position = (cell_location * 16) + Vector2i(8, 16)
	return null
	
func generate_cave(world_size: Vector2i) -> void:
	
	stone_layer.clear()
	
	for layer: String in GlobalEnums.CAVE_LAYERS.data:
		
		var layer_data: Dictionary = GlobalEnums.CAVE_LAYERS.data.get(layer)
		for y: int in layer_data["layer_end"]:
			var true_y: int = layer_data["layer_start"] + y
			if true_y >= layer_data["layer_end"]:
				break
			for x in world_size.x:
				var current_pos: Vector2i = Vector2i(x, true_y)
				var random_ore: Ore = _get_random_ore(current_pos, layer_data)
				if not random_ore:
					printerr("ore could not be created at: " + str(current_pos))
					return
				
				var ore_texture_origin: Dictionary = GlobalEnums.ORES.data[random_ore.id]["texture_origin"]
				var texture_origin: Vector2i = Vector2i(ore_texture_origin["x"],ore_texture_origin["y"])
				stone_layer.set_cell(current_pos, 0, texture_origin)
				ore_dictionary.merge({current_pos: random_ore})

func _get_random_ore(pos: Vector2i, layer_data: Dictionary) -> Ore:
	var new_ore: Ore = Ore.new(layer_data["ore_id"], GlobalEnums.ORES.data.get("stone"))
	var total_weight: float = 0.0
	
	var possible_random_ore_list: Array[String] = []
	var possible_random_ore_probability: Array[float] = []
	
	if not layer_data.include_ore:
		var ore_data: Dictionary = GlobalEnums.ORES.data.get(layer_data["ore_id"])
		new_ore = Ore.new(layer_data["ore_id"], ore_data)
		return new_ore
		
	for ore_name: String in GlobalEnums.ORES.data:
		ore_name = ore_name.to_lower()
		var ore_data: Dictionary = GlobalEnums.ORES.data.get(ore_name)
		if pos.y > ore_data.height_min && pos.y <= ore_data.height_max:
			possible_random_ore_list.append(ore_name)
			
			var probability: float = ore_data.chance_min
			
			possible_random_ore_probability.append(probability)
			
			total_weight += probability
			
	
	var rand: float = randf_range(0.0, total_weight)
	var updated_drop_value: float = 0.0
	
	for i in possible_random_ore_list.size():
		updated_drop_value += possible_random_ore_probability[i]
		if rand <= updated_drop_value:
			if possible_random_ore_list[i] == null:
				return
			
			new_ore = Ore.new(possible_random_ore_list[i], GlobalEnums.ORES.data.get(possible_random_ore_list[i]))
			break
	
	return new_ore
