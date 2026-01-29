extends Node

const ORES = preload("res://src/generation/ores.json")
const CAVE_LAYERS = preload("res://src/generation/cave_layers.json")

enum ROCK_STRENGTHS {
	SOFT,
	HARD,
	TOUGH,
	TITANIC
}
