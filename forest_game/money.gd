extends Label

@onready var health = $"../health"

func _process(delta: float) -> void:
	text = "Money: " + str(GameManager.money)
	health.text = "Health: " + str(GameManager.forest_health)
