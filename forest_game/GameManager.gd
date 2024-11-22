extends Node

enum tower_types {
	TURTLE,
	SQUIRREL,
	DEER
}

var tower_sprites = {
	tower_types.TURTLE : preload("res://art/turtle.png"),
	tower_types.SQUIRREL : preload("res://art/squirrel.png"),
	tower_types.DEER : preload("res://art/deer (2).png")
}

var tower_instances = {
	tower_types.TURTLE : "res://turtle_tower.tscn",
	tower_types.SQUIRREL : "res://squirrel_tower.tscn",
	tower_types.DEER : "res://deer_tower.tscn"
}

var tower_ranges = {
	tower_types.TURTLE : 1000,
	tower_types.SQUIRREL : 500,
	tower_types.DEER : 200
}

var tower_costs = {
	tower_types.TURTLE : 200,
	tower_types.SQUIRREL : 400,
	tower_types.DEER : 500
}

var forest_health = 50

var money = 500
