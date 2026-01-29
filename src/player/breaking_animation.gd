extends Sprite2D

signal breaking_cancelled(sprite: Sprite2D)

var stages: int = 8
var current_stage: int = 0

var break_delay: int = 3
var current_delay: int = 0
var elapsed_time: float = 0.0

func _ready() -> void:
	current_delay = break_delay
	
	vframes = 1
	hframes = 8

func _physics_process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time < 1.0:
		return
	
	elapsed_time = 0.0
	current_delay -= 1
	
	if current_delay > 0:
		return
		
	current_delay = break_delay
	
	current_stage -= 1
	if current_stage <= 0:
		breaking_cancelled.emit(self)
		queue_free()
