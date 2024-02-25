extends RigidBody2D


class_name RigidPlayer

const SPEED = 300

var HEALTH = 100
var RESOURCES = {
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
	RESOURCES[rock_type] += resource_amount

func _on_body_entered(body):
	if body is Rock:
		print("Player hit Rock")
		# 1. Hit rock for damage
		# 2. Take damage from rock
		# TODO: replace with player damage variable
		body.hit(1)
		HEALTH -= Global.DAMAGE_TABLE[body.getRockType()]
		if HEALTH <= 0:
			print("Player dead")
			SignalBus.player_dead.emit()
	elif body is Core:
		print("Player hit Core")
