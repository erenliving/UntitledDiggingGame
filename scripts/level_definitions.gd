extends Node

var current_level = 1

var level_1 = {
	core_radius = 15,
	rock_layers = [
		Global.RockType.IRON, 
		Global.RockType.ROCK, 
		Global.RockType.ROCK, 
		Global.RockType.DIRT, 
		Global.RockType.DIRT, 
		Global.RockType.DIRT
	]
}
var level_2 = {
	core_radius = 50,
	rock_layers = [
		Global.RockType.COBALT, 
		Global.RockType.COBALT, 
		Global.RockType.COBALT,
		Global.RockType.ALUMINUM,
		Global.RockType.ALUMINUM,
		Global.RockType.ALUMINUM,
		Global.RockType.ALUMINUM,
		Global.RockType.ALUMINUM,
		Global.RockType.COPPER,
		Global.RockType.COPPER,
		Global.RockType.COPPER,
		Global.RockType.COPPER,
		Global.RockType.COPPER,
		Global.RockType.COPPER,
		Global.RockType.COPPER,
		Global.RockType.COPPER
	]
}
var levels = [
	level_1,
	level_2
]

func get_current_level_definition():
	return levels[current_level - 1]
