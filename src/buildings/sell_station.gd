extends Area2D
class_name SellStation

var selling_items_queue: Array
var sell_delay: float = 0.2
var elapsed_time: float = 0.0

func sell_ores(player: Player) -> void:
	selling_items_queue.append(player)

func _physics_process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time < sell_delay:
		return
	elapsed_time = 0.0
	
	if selling_items_queue.is_empty():
		return
	
	var current_player: Player = selling_items_queue.get(0)
	if current_player.inventory.inventory_contents.is_empty():
		selling_items_queue.remove_at(0)
		return
	
	var ore_id: String = current_player.inventory.inventory_contents.keys().get(0)
	current_player.inventory.remove_from_inventory(Ore.new(ore_id, {}), 1)
	current_player.ingame_gui.add_money(GlobalEnums.ORES.data.get(ore_id)["worth"])

	var new_floating_item: Sprite2D = ItemSellingTemplate.new(current_player.global_position, global_position, "res://assets/ores/SpriteSheet.png")
	new_floating_item.top_level = true
	new_floating_item.frame_coords = Vector2i(GlobalEnums.ORES.data.get(ore_id)["texture_origin"]["x"], GlobalEnums.ORES.data.get(ore_id)["texture_origin"]["y"])
	add_child(new_floating_item)
