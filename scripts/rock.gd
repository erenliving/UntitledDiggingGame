extends RigidBody2D


class_name Rock

@export var ROCK_TYPE: Global.RockType = Global.RockType.DIRT
var RESOURCE_AMOUNT: int
var HEALTH: int

func _ready():
	setRockProperties(ROCK_TYPE)

func setRockProperties(new_rock_type: Global.RockType):
	RESOURCE_AMOUNT = Global.RESOURCE_TABLE[new_rock_type]
	HEALTH = Global.ROCK_HEALTH_TABLE[new_rock_type]

func setRockType(new_rock_type: Global.RockType):
	ROCK_TYPE = new_rock_type
	setRockProperties(new_rock_type)

func getRockType():
	return ROCK_TYPE

func hit(damage: int):
	print("Rock hit with damage ", damage)
	HEALTH -= damage
	if HEALTH <= 0:
		print("Rock destroyed")
		SignalBus.rock_destroyed.emit(ROCK_TYPE, RESOURCE_AMOUNT)
		queue_free()
