extends Node


class_name LevelBuilder

@export var core_scene: PackedScene
@export var rock_scene: PackedScene

func _ready():
	build_level(LevelDefinitions.get_current_level_definition())

func build_level(level_definition):
	var origin = Vector2.ZERO
	
	var core = core_scene.instantiate() as Core
	add_child(core)
	core.set_position(origin)
	core.radius = level_definition.core_radius
	
	var rock_offset = 5
	var layer_offset = 10
	var initial_radius = level_definition.core_radius + rock_offset
	var current_layer = 0
	for i in range(level_definition.rock_types.size()):
		var rock_type = level_definition.rock_types[i]
		var rock_layers = level_definition.rock_layers[i]
		for j in range(rock_layers):
			var current_radius = initial_radius + (current_layer * layer_offset)
			print("Spawning rock type %s in layer %d at radius %d" % [rock_type, j, current_radius])
			spawn_rocks_in_circle(20, current_radius, level_definition.rock_types[i], origin)
			current_layer += 1

func spawn_rocks_in_circle(n: int, r: float, rock_type: Global.RockType, center = Vector2.ZERO):
	var offset = 2.0 * PI / abs(n)
	for i in range(n):
		var theta = i * offset
		var pos = Vector2.from_angle(theta) * r
		var rock = rock_scene.instantiate() as Rock
		add_child(rock)
		rock.set_position(center + pos)
		rock.setRockType(rock_type)
