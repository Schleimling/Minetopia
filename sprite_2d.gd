extends Sprite2D
class_name ItemSellingTemplate

var origin: Vector2
var target_position: Vector2

var speed: float = 64.0

var lifetime: float = 20

func _init(source: Vector2, target: Vector2, texture_src: String) -> void:
	origin = source
	target_position = target
	
	texture = load(texture_src)
	
	scale = Vector2(0.5, 0.5)
	
	hframes = 32
	vframes = 32

func _ready() -> void:
	global_position = origin

func _physics_process(delta: float) -> void:
	lifetime -= delta
	var dir: Vector2 = (origin - target_position).normalized()
	global_position += (-dir * speed) * delta
	
	if global_position.distance_to(target_position) <= 2  || lifetime <= 0:
		queue_free()
	
