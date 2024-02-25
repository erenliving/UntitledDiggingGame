extends CanvasLayer


signal start_game

@onready var message = $Message
@onready var message_timer = $MessageTimer
@onready var start_button = $StartButton
@onready var dirt = $ScrollContainer/ResourcesVBox/Dirt
@onready var rock = $ScrollContainer/ResourcesVBox/Rock
@onready var iron = $ScrollContainer/ResourcesVBox/Iron
@onready var copper = $ScrollContainer/ResourcesVBox/Copper
@onready var aluminum = $ScrollContainer/ResourcesVBox/Aluminum
@onready var cobalt = $ScrollContainer/ResourcesVBox/Cobalt

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(text):
	message.text = text
	message.show()
	message_timer.start()

func show_level_over():
	show_message("Level over!")
	await message_timer.timeout
	
	message.text = "Drill the core!"
	message.show()
	# Create a one shot timer and wait for it
	await get_tree().create_timer(1.0).timeout
	start_button.show()

func update_resource(rock_type: Global.RockType, amount: int):
	match rock_type:
		Global.RockType.DIRT:
			dirt.text = "Dirt: %d" % amount
		Global.RockType.ROCK:
			rock.text = "Rock: %d" % amount
		Global.RockType.IRON:
			iron.text = "Iron: %d" % amount
		Global.RockType.COPPER:
			copper.text = "Copper: %d" % amount
		Global.RockType.ALUMINUM:
			aluminum.text = "Aluminum: %d" % amount
		Global.RockType.COBALT:
			cobalt.text = "Cobalt: %d" % amount
		

func _on_start_button_pressed():
	start_button.hide()
	start_game.emit()

func _on_message_timer_timeout():
	message.hide()
