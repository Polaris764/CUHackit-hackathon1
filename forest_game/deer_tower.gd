extends Node2D

var enemy_targets = []


func _on_range_area_entered(area: Area2D) -> void:
	if not area.is_in_group("tower") and not area.is_in_group("towerR"):
		enemy_targets.append(area)

func _on_range_area_exited(area: Area2D) -> void:
	if area in enemy_targets:
		enemy_targets.erase(area)

@onready var projectile = preload("res://deer_projectile.tscn")
func _on_attack_timer_timeout() -> void:
	if enemy_targets.size() > 0:
		print("shooting")
		var proj = projectile.instantiate()
		proj.target_pos = enemy_targets[0].global_position
		get_tree().get_root().add_child(proj)
		proj.global_position = global_position
		proj.look_at(enemy_targets[0].global_position+Vector2(0,-200))
		print(enemy_targets[0].global_position)
		$delay_attack.start(.6)

func _on_delay_attack_timeout() -> void:
	var proj = projectile.instantiate()
	proj.target_pos = enemy_targets[0].global_position
	get_tree().get_root().add_child(proj)
	proj.global_position = global_position
	proj.look_at(enemy_targets[0].global_position+Vector2(0,-200))
