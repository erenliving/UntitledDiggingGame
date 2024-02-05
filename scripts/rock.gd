extends RigidBody2D


class_name Rock

@export var ROCK_TYPE: Global.RockType = Global.RockType.DIRT
@export var RESOURCE_AMOUNT: int = 0
var HEALTH = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	HEALTH = Global.ROCK_HEALTH_TABLE[ROCK_TYPE]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setRock(new_rock_type: Global.RockType, new_resource_amount: int):
	ROCK_TYPE = new_rock_type
	RESOURCE_AMOUNT = new_resource_amount

func getRockType():
	return ROCK_TYPE

func hit(damage: int):
	print("Rock hit with damage ", damage)
	HEALTH -= damage
	if HEALTH <= 0:
		print("Rock destroyed")
		SignalBus.rock_destroyed.emit(ROCK_TYPE, RESOURCE_AMOUNT)
		queue_free()
