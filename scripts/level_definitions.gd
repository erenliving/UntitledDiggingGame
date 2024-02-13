extends Node

var current_level = 1

var level_1 = {
	core_radius = 15,
	rock_types = [Global.RockType.IRON, Global.RockType.ROCK, Global.RockType.DIRT],
	rock_layers = [1, 2, 3]
}
var level_2 = {
	core_radius = 50,
	rock_types = [Global.RockType.COBALT, Global.RockType.ALUMINUM, Global.RockType.COPPER],
	rock_layers = [3, 5, 8]
}
var levels = [
	level_1,
	level_2
]

func get_current_level_definition():
	return levels[current_level - 1]
