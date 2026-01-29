extends Node
class_name Inventory

@export var max_inventory_size: int = 64

var inventory_contents: Dictionary[String, int]

func put_in_inventory(ore: Ore, amount: int = 1) -> bool:
	var current_backpack_size: int = 0
	for i in inventory_contents:
		current_backpack_size += inventory_contents.get(i)
	
	if inventory_contents.has(ore.id):
		var inventory_ore: int = inventory_contents.get(ore.id)
		inventory_contents.set(ore.id, inventory_ore + amount)
	else:
		inventory_contents.merge({ore.id: amount})
		
	if current_backpack_size >= max_inventory_size:
		notify_full_backpack()
		return false
	
	return true

func remove_from_inventory(ore: Ore, amount: int) -> void:
	var inventory_ore: int = inventory_contents.get(ore.id)
	var new_amount: int = inventory_ore - amount
	if new_amount <= 0:
		inventory_contents.erase(ore.id)
		return
	
	inventory_contents.set(ore.id, new_amount)

func notify_full_backpack() -> void:
	print("Backpack full!")
	pass
