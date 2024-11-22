extends PathFollow2D

@export var speed = 50
@export var health = 0

@onready var hurt = $hurt
@onready var death = $death

var dying = false
@onready var sprite = $sprite

var last_pos : Vector2
func _process(delta: float) -> void:
	progress += speed*delta
	if global_position != last_pos:
		if global_position.x < last_pos.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	last_pos = global_position
	if not dying and health <= 0:
		dying = true
		death.play(.74)
		speed = 0
		GameManager.money += 100
		sprite.play("death")
		$death_timer.start()

@onready var hit_slash = preload("res://slash.tscn")
@onready var hit_marker = preload("res://hit_sprite.tscn")
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("forest"):
		# dealt damage
		GameManager.forest_health -= 2
		var hit = hit_slash.instantiate()
		hit.global_position = $sprite.global_position
		get_tree().get_root().add_child(hit)
		queue_free()
	else:
		# took damage
		hurt.play(.1)
		health -= 1
		var hit = hit_marker.instantiate()
		hit.global_position = $sprite.global_position
		get_tree().get_root().add_child(hit)

func _on_death_timer_timeout() -> void:
	queue_free()
