extends RigidBody2D


signal rock_destroyed(rock_type: Global.RockType, resource_amount: int)

@export var ROCK_TYPE: Global.RockType = Global.RockType.DIRT
@export var RESOURCE_AMOUNT: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#var player = get_node("../Player")
	#self.rock_destroyed.connect(player._on_rock_destroyed)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setRock(new_rock_type: Global.RockType, new_resource_amount: int):
	ROCK_TYPE = new_rock_type
	RESOURCE_AMOUNT = new_resource_amount


func _on_body_entered(body):
	rock_destroyed.emit(ROCK_TYPE, RESOURCE_AMOUNT)
	queue_free()
