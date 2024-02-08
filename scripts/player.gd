extends CharacterBody2D


class_name Player

@export var SPEED = 300.0
var HEALTH = 100
var RESOURCES = {Global.RockType.DIRT: 0, Global.RockType.ROCK: 0, Global.RockType.IRON: 0}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	SignalBus.rock_destroyed.connect(_on_rock_destroyed)

func get_input():
	look_at(get_global_mouse_position())
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_dir * SPEED

func _physics_process(delta):
	get_input()
	
	# Add the gravity.
	if not is_on_floor():
		if position.y < 0:
			velocity.y += gravity * delta
		else:
			velocity.y -= gravity * delta
		if position.x < 0:
			velocity.x += gravity * delta
		else:
			velocity.x -= gravity * delta
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		
		if collision.get_collider() is Rock:
			print("Player hit Rock")
			var rock = collision.get_collider()
			# TODO: replace with player damage variable
			rock.hit(1)
			HEALTH -= Global.DAMAGE_TABLE[rock.getRockType()]
			if HEALTH <= 0:
				print("Player dead")
				SignalBus.player_dead.emit()

func _on_rock_destroyed(rock_type: Global.RockType, resource_amount: int):
	print("Player received rock destroyed for type ", rock_type, " and amount ", resource_amount)
	RESOURCES[rock_type] += resource_amount
