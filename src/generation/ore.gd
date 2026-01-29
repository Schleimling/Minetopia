extends RefCounted
class_name Ore

var id: String
var health: int = 20
var strength: GlobalEnums.ROCK_STRENGTHS = GlobalEnums.ROCK_STRENGTHS.SOFT
var weight: float = 0.01


var breaking_anim: Sprite2D

func _init(id: String, ore_data: Dictionary) -> void:
	
	if id.is_empty():
		printerr(id + " could not be found")
		return
	
	self.id = id
	
	if not ore_data:
		return
	
	health = ore_data["max_health"]
	strength = ore_data["strength"]

func try_damage(pickaxe_damage: int, pickaxe_strength: int) -> bool:
	if strength > pickaxe_strength:
		return false
	
	health -= pickaxe_damage
	
	if health <= 0:
		if breaking_anim:
			breaking_anim.queue_free()
		return true
	
	return false
