@tool
extends Node2D


class_name Core

@export var radius: float = 100
@export var health: int = 100

@onready var collision_shape_2d = $StaticBody2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	(collision_shape_2d.shape as CircleShape2D).radius = radius


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _draw():
	draw_circle(Vector2.ZERO, radius, Color.LIGHT_CORAL)
