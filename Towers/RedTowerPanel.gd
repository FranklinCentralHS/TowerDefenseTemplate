extends Panel

@onready var tower = preload("res://Towers/RedBullet.tscn")
var currTile


func _on_gui_input(event):
	var tempTower = tower.instantiate()
	print(event)
