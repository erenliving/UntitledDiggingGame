extends Node

signal rock_destroyed(rock_type: Global.RockType, resource_amount: int)
signal player_collected_resource(rock_type: Global.RockType, total_amount: int)
signal player_dead
