extends Panel


@onready var tower = preload("res://smallboy_1.tscn")
var currTile

func _on_gui_input(event):
	var tempTower = tower.instantiate()
	
	if event is InputEventMouseButton and event.button_mask == 1:
		# Left Click down
		add_child(tempTower)
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
		tempTower.scale = Vector2(4.32, 4.32)
	
	elif event is InputEventMouseMotion and event.button_mask == 1:
		# Left Click down Drag
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position
	
	elif event is InputEventMouseButton and event.button_mask == 0:
		# Left Click Up
		if get_child_count() > 1 and event.global_position.x < 62.5: 
			# Only queue_free if the tower is inside a specific area, based on the x position
			get_child(1).queue_free()
		else:
			# If outside the area, keep the tower but adjust position or logic as needed
			if get_child_count() > 1:
				var placed_tower = get_child(1)
				placed_tower.global_position = event.global_position
				return
			var path = get_tree().get_root().get_node("main/Towers")
					
			path.add_child(tempTower)
			tempTower.global_position = get_global_mouse_position()
			tempTower.get_node("Panel").hide()
			get_child(1).queue_free()
