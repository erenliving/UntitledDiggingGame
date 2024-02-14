class_name Global

enum RockType {DIRT, ROCK, IRON, COPPER, ALUMINUM, COBALT}

const DAMAGE_TABLE = {
	RockType.DIRT: 1, 
	RockType.ROCK: 5, 
	RockType.IRON: 25, 
	RockType.COPPER: 15, 
	RockType.ALUMINUM: 10, 
	RockType.COBALT: 50
}
const ROCK_HEALTH_TABLE = {
	RockType.DIRT: 1, 
	RockType.ROCK: 10, 
	RockType.IRON: 50, 
	RockType.COPPER: 50, 
	RockType.ALUMINUM: 50, 
	RockType.COBALT: 50
}
const RESOURCE_TABLE = {
	RockType.DIRT: 5, 
	RockType.ROCK: 10, 
	RockType.IRON: 1,
	RockType.COPPER: 5, 
	RockType.ALUMINUM: 3, 
	RockType.COBALT: 1
}
const ROCK_COLOR_TABLE = {
	RockType.DIRT: Color.BROWN, 
	RockType.ROCK: Color.GRAY, 
	RockType.IRON: Color.SILVER, 
	RockType.COPPER: Color.ORANGE_RED, 
	RockType.ALUMINUM: Color.WHITE, 
	RockType.COBALT: Color.BLUE
}
