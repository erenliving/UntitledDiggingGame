extends Node


class_name LevelBuilder

@export var core_scene: PackedScene
@export var rock_scene: PackedScene

func _ready():
	build_level(LevelDefinitions.get_current_level_definition())

func build_level(level_definition):
	var origin = Vector2.ZERO
	
	spawn_core(origin, level_definition.core_radius)
	spawn_rocks(origin, level_definition)

func spawn_core(position: Vector2, radius: float):
	var core = core_scene.instantiate() as Core
	# Set radius property before adding as child so it's collision shape is correct size
	core.radius = radius
	add_child(core)
	core.set_position(position)

func spawn_rocks(center: Vector2, level_definition):
	var first_layer_offset = 5
	var initial_radius = level_definition.core_radius + first_layer_offset
	var layer_offset = 10
	var current_layer = 0
	for i in range(level_definition.rock_layers.size()):
		var rock_type = level_definition.rock_layers[i]
		var current_radius = initial_radius + (i * layer_offset)
		var current_circumference = 2 * PI * current_radius
		# Opt to round up on number of objects here, prefer to have some overlap over some gaps
		var num_rocks = ceil(current_circumference / 10)
		spawn_rocks_in_circle(num_rocks, current_radius, rock_type, center)
		current_layer += 1

func spawn_rocks_in_circle(n: int, r: float, rock_type: Global.RockType, center = Vector2.ZERO):
	var offset = 2.0 * PI / abs(n)
	for i in range(n):
		var theta = i * offset
		var pos = Vector2.from_angle(theta) * r
		var rock = rock_scene.instantiate() as Rock
		add_child(rock)
		rock.set_position(center + pos)
		# Rotate the sprite to have its "bottom" point towards circle center
		# Makes the circle look a bit better
		rock.set_rotation(theta - (PI / 2))
		rock.setRockType(rock_type)
