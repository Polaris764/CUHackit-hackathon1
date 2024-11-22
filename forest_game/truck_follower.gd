extends PathFollow2D

@export var speed = 30
@export var health = 0

var dying = false
@onready var sprite = $sprite
@onready var smoke = $sprite/smoke

@onready var hurt = $hurt2q
@onready var death = $death

var last_pos : Vector2
func _process(delta: float) -> void:
	progress += speed*delta
	if global_position != last_pos:
		if global_position.x < last_pos.x:
			sprite.flip_h = true
			smoke.offset.x = 436
		else:
			sprite.flip_h = false
			smoke.offset.x = 218
	last_pos = global_position
	if not dying and health <= 0:
		dying = true
		speed = 0
		death.play()
		GameManager.money += 500
		smoke.visible = true
		smoke.play("default")
		$death_timer.start()

@onready var hit_slash = preload("res://slash.tscn")
@onready var hit_marker = preload("res://hit_sprite.tscn")
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("forest"):
		# dealt damage
		GameManager.forest_health -= 5
		var hit = hit_slash.instantiate()
		hit.global_position = $sprite.global_position
		get_tree().get_root().add_child(hit)
		queue_free()
	else:
		# took damage
		health -= 1
		hurt.play()
		var hit = hit_marker.instantiate()
		hit.global_position = $sprite.global_position
		get_tree().get_root().add_child(hit)

func _on_death_timer_timeout() -> void:
	queue_free()
