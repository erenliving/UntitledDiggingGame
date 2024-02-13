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
	
	var rock_offset = 0
	var layer_offset = 10
	var initial_radius = level_definition.core_radius + rock_offset
	for i in range(level_definition.rock_types.size()):
		for j in range(level_definition.rock_layers[i]):
			var current_radius = initial_radius + (j * layer_offset)
			spawn_rocks_in_circle(20, current_radius, level_definition.rock_types[i], origin)
	
	#spawn_rocks_in_circle(20, 50, Global.RockType.IRON, origin)
	#spawn_rocks_in_circle(30, 60, Global.RockType.ROCK, origin)
	#spawn_rocks_in_circle(40, 70, Global.RockType.DIRT, origin)

func spawn_rocks_in_circle(n: int, r: float, rock_type: Global.RockType, center = Vector2.ZERO):
	var offset = 2.0 * PI / abs(n)
	for i in range(n):
		var theta = i * offset
		var pos = Vector2.from_angle(theta) * r
		var rock = rock_scene.instantiate() as Rock
		add_child(rock)
		rock.set_position(center + pos)
		rock.setRockType(rock_type)
