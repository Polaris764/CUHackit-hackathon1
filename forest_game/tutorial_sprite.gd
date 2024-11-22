extends Sprite2D

func disappear():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 1)
	#tween.tween_callback(self.queue_free)

func _on_timer_timeout() -> void:
	disappear()
