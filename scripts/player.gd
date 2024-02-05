extends CharacterBody2D


signal player_dead

@export var SPEED = 300.0
var HEALTH = 100
var RESOURCES = {Global.RockType.DIRT: 0, Global.RockType.ROCK: 0, Global.RockType.IRON: 0}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_dir * SPEED

func _physics_process(delta):
	get_input()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# TODO: Fix rotation so player points towards mouse
	#var mouse_dir = get_global_mouse_position() - global_position
	#rotation = mouse_dir.angle()
	look_at(get_global_mouse_position())

	var collision = move_and_collide(velocity * delta)
	if collision:
		print("Player collided with ", collision.get_collider().name)
		velocity = velocity.bounce(collision.get_normal())
		
		# TODO: if collision is with a block, take some damage, collect some resources (eventually convert these to signals)
		if collision.get_collider().has_method("block_hit"):
			collision.get_collider().block_hit()

func _on_rock_destroyed(rock_type: Global.RockType, resource_amount: int):
	print("Player received rock destroyed for type ", rock_type, " and amount ", resource_amount)
	RESOURCES[rock_type] += resource_amount
	HEALTH -= Global.DAMAGE_TABLE[rock_type]
	if HEALTH <= 0:
		player_dead.emit()
