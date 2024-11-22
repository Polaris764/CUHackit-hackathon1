extends Control

@onready var tButton = preload("res://tower_button.tscn")
@onready var button_holder = $tower_button_holder
@onready var cFollower = preload("res://cursor_follower.tscn")
@onready var placing = false
var current_temp_type
var current_temp_sprite

func _ready():
	for tower_type in GameManager.tower_types:
		var tempBut = tButton.instantiate()
		button_holder.add_child(tempBut)
		tempBut.tower_type = GameManager.tower_types[tower_type]
		tempBut.get_node("name").text = tower_type.capitalize()
		tempBut.get_node("sprite").texture = GameManager.tower_sprites[GameManager.tower_types[tower_type]]
		if tower_type == GameManager.tower_types.keys()[GameManager.tower_types.DEER]:
			tempBut.get_node("sprite").scale = Vector2(.8,.8)
			tempBut.get_node("sprite").position += Vector2(10,0)
		tempBut.pressed.connect(placing_tower.bind(tempBut))

func placing_tower(tower_button):
	current_temp_type = null
	if current_temp_sprite != null:
		current_temp_sprite.queue_free()
		current_temp_sprite = null
	placing = true
	var spriteTemp = cFollower.instantiate()
	current_temp_sprite = spriteTemp
	spriteTemp.get_node("range").scale = Vector2(GameManager.tower_ranges[tower_button.tower_type]/930*30,GameManager.tower_ranges[tower_button.tower_type]/930*30)
	print("image instantiated")
	print(tower_button.tower_type)
	current_temp_type = tower_button.tower_type
	get_tree().get_root().add_child(spriteTemp)
	spriteTemp.texture = GameManager.tower_sprites[tower_button.tower_type]

func _input(event: InputEvent) -> void:
	if placing:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if check_valid_placement():
					print("placing")
					var instanceT = load(GameManager.tower_instances[current_temp_type]).instantiate()
					get_tree().get_nodes_in_group("main")[0].add_child(instanceT)
					instanceT.global_position = current_temp_sprite.global_position
					if current_temp_sprite:
						current_temp_sprite.queue_free()
					placing = false

@onready var warning_label = preload("res://warning_label.tscn")
@onready var warning_holder = $"../warning_holder"
func create_warning(text : String):
	var labX = warning_label.instantiate()
	labX.text = text
	warning_holder.add_child(labX)
	warning_holder.move_child(labX,3)
	
func check_valid_placement():
# check for valid placement
	var valid_placement = true
	if current_temp_sprite.get_node("Area2D").get_overlapping_areas().size() > 0:
		for overlap in current_temp_sprite.get_node("Area2D").get_overlapping_areas().size():
			if current_temp_sprite.get_node("Area2D").get_overlapping_areas()[overlap].is_in_group("tower"):
				# overlapping with towers
				valid_placement = false
				print("overlapping with tower")
				create_warning("Overlapping with tower!")
	if get_tree().get_first_node_in_group("water_area").get_overlapping_areas().size() > 0:
		# is in water
		if current_temp_type != GameManager.tower_types.TURTLE:
			valid_placement = false
			print("in water and not turtle")
			create_warning("Cannot place this tower on beach/water!")
	elif get_tree().get_first_node_in_group("water_area").get_overlapping_areas().size() == 0:
		if current_temp_type == GameManager.tower_types.TURTLE:
			valid_placement = false
			print("in not water and turtle")
			create_warning("Must place this tower on beach/water!")
	if get_tree().get_first_node_in_group("path_area").get_overlapping_areas().size() > 0:
		# is in path
		valid_placement = false
		print("in path")
		create_warning("Cannot place towers in path!")
	if get_tree().get_first_node_in_group("off_area").get_overlapping_areas().size() > 0:
		# is off map
		valid_placement = false
		print("out of map")
		create_warning("Must place towers in the map!")
	return valid_placement
