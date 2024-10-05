extends TowerPanel




func _on_gui_input(event):
	var tempTower = tower
	if event is InputEventMouseButton and event.button_mask == 1:
		#Left button down
		add_child(tempTower)

		#tempTower.process_mode = Node.PROCESS_MODE_DISABLED

		#tempTower.scale = Vector2(0.32,0.32)

	elif event is InputEventMouseButton and event.button_mask == 1:
		#left click down drag
		get_child(1).global_position = get_global_mouse_position()
		tempTower.global_postion = get_global_mouse_position()
	elif event is InputEventMouseButton and event.button_mask == 0:
		#left click up
		
		#get_child(1).queue_free()
		var path = get_tree().get_root().get_node("Main/Towers")

		path.add_child(tempTower)
		#tempTower.global_position = get_global_mouse_position()
		#tempTower.get_node("Panel").hide()
#everything is showing errors when it is the exact code as the working panel like everyhthing is showing as nule when it is connected to the parent
