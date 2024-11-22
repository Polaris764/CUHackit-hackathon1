extends Sprite2D

func _ready() -> void:
	rotation = randi_range(0,360)

func _on_timer_timeout() -> void:
	queue_free()
