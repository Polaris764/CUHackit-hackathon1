extends Node2D

@onready var lumberjack_timer = $Lspawning_timer
@onready var truck_timer = $Tspawning_timer
@onready var difficulty_timer = $difficulty_timer
@onready var lumberjack = preload("res://enemy.tscn")
@onready var truck = preload("res://truck_follower.tscn")
@onready var spawn_location = $spawn_location
@onready var difficulty_label = $menu_canvas/warning_holder.get_node("difficulty")
var difficulty = 0

func _ready():
	match difficulty:
		0:
			spawn_truck()
			lumberjack_timer.start(8)
			truck_timer.start(9999)
		1:
			spawn_truck()
			lumberjack_timer.start(4)
		2:
			spawn_truck()
			truck_timer.start(10)
		3:
			spawn_truck()
			lumberjack_timer.start(3)
			truck_timer.start(7)
		4:
			spawn_truck()
			lumberjack_timer.start(2)
			truck_timer.start(5)
		5:
			spawn_truck()
			lumberjack_timer.start(2)
			truck_timer.start(3)
		6:
			spawn_truck()
			lumberjack_timer.start(1)
			truck_timer.start(1)
			
			

func spawn_lumberjack():
	var lj = lumberjack.instantiate()
	get_tree().get_first_node_in_group("main").get_node("enemy_path").add_child(lj)
	lj.global_position = spawn_location.global_position
	if difficulty == 3:
		lj.speed *= 1.5
	elif difficulty > 3:
		lj.speed *= 2

func spawn_truck():
	var tr = truck.instantiate()
	get_tree().get_first_node_in_group("main").get_node("enemy_path").add_child(tr)
	tr.global_position = spawn_location.global_position


func _on_lspawning_timer_timeout() -> void:
	spawn_lumberjack()

func _on_tspawning_timer_timeout() -> void:
	spawn_truck()

func _on_difficulty_timer_timeout() -> void:
	difficulty += 1
	difficulty_label.text = "Difficulty: " + str(difficulty)
