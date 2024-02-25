@tool
extends Node2D


class_name Core

@export var radius: float = 50
@export var health: int = 100

@onready var collision_shape_2d = $StaticBody2D/CollisionShape2D

func _ready():
	(collision_shape_2d.shape as CircleShape2D).radius = radius

func _draw():
	draw_circle(Vector2.ZERO, radius, Color.LIGHT_CORAL)
