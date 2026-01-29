extends Node2D

const ROPE_SEGMENT = preload("uid://d0d6qyhi1s2d1")

@onready var rope_segments: Node2D = $RopeSegments

var previous_segment: RopeSegment

var tool_pinjoint: PinJoint2D

var holder: PhysicsBody2D
var target: PhysicsBody2D

func generate_rope(length: int) -> void:
	for i in range(length):
		if not previous_segment:
			generate_starter_rope()
			continue
		generate_rope_segment()
	generate_last_segment()

func generate_starter_rope() -> void:
	var new_rope_segment: RopeSegment = ROPE_SEGMENT.instantiate()
	add_child(new_rope_segment)
	new_rope_segment.pin_joint_2d.node_a = new_rope_segment.get_path()
	new_rope_segment.pin_joint_2d.node_b = holder.get_path()
	
	previous_segment = new_rope_segment

func generate_rope_segment() -> void:
	var new_rope_segment: RopeSegment = ROPE_SEGMENT.instantiate()
	add_child(new_rope_segment)
	new_rope_segment.position = previous_segment.position + Vector2(0, 8.0)
	connect_segments(new_rope_segment, previous_segment)
	previous_segment = new_rope_segment
	
func generate_last_segment() -> void:
	if tool_pinjoint:
		tool_pinjoint.queue_free()
		
	tool_pinjoint = PinJoint2D.new()
	add_child(tool_pinjoint)
	tool_pinjoint.node_a = previous_segment.get_path()
	tool_pinjoint.node_b = target.get_path()

func connect_segments(segment1: RopeSegment, segment2: RopeSegment) -> void:
	segment1.pin_joint_2d.node_a = segment1.get_path()
	segment1.pin_joint_2d.node_b = segment2.get_path()
	
