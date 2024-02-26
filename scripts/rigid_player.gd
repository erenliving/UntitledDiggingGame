extends RigidBody2D


class_name RigidPlayer

const SPEED = 300

var start_position = Vector2(0, -500)
var health = 100
var resources = {
	Global.RockType.DIRT: 0, 
	Global.RockType.ROCK: 0, 
	Global.RockType.IRON: 0, 
	Global.RockType.COPPER: 0, 
	Global.RockType.ALUMINUM: 0, 
	Global.RockType.COBALT: 0
}
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	start_position = position
	SignalBus.rock_destroyed.connect(_on_rock_destroyed)

func _integrate_forces(state):
	SmoothLookAt.smoothLookAtRigid(self, get_global_mouse_position(), 10)
	
	# Input force
	var input_dir = Input.get_vector("left", "right", "up", "down")
	state.apply_force(input_dir * SPEED)
	
	# Gravity force
	#TODO: Use the project settings value for gravity
	state.apply_force((Vector2.ZERO - position).normalized() * 10)

func _on_rock_destroyed(rock_type: Global.RockType, resource_amount: int):
	print("Player received rock destroyed for type ", rock_type, " and amount ", resource_amount)
	resources[rock_type] += resource_amount
	print(resources)
	SignalBus.player_collected_resource.emit(rock_type, resources[rock_type])

func _on_body_entered(body):
	if body is Rock:
		var rock_type = body.getRockType()
		print("Player hit %s" % rock_type)
		# 1. Hit rock for damage
		# 2. Take damage from rock
		# TODO: replace with player damage variable
		body.hit(1)
		health -= Global.DAMAGE_TABLE[rock_type]
		if health <= 0:
			print("Player dead")
			SignalBus.player_dead.emit()
			position = start_position
	elif body is Core:
		print("Player hit Core")
