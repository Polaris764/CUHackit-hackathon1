extends TextureButton

@export var tower_type: GameManager.tower_types
var cost_number

func _ready():
	cost_number = GameManager.tower_costs[tower_type]
	print(cost_number)
	cost.text = "Cost: " + str(cost_number)

@onready var cost = $cost
func _process(delta: float) -> void:
	if GameManager.money >= cost_number:
		disabled = false
		self_modulate = Color(1,1,1)
	else:
		disabled = true
		self_modulate = Color.RED

func _on_pressed() -> void:
	GameManager.money -= cost_number
