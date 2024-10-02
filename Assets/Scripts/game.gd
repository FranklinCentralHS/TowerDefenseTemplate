extends Node2D

var bat = preload("res://Scenes/bat.tscn")
var towerWeak = preload("res://Scenes/tower_weak.tscn")

var path;

var remainingEnemies = 5;
var towers = [];

func _ready():
	path = get_node("Map/Path2D")

func _on_spawn_timer_timeout():
	if remainingEnemies > 0:
		print("adding new bat")
		var newBat = bat.instantiate()
		remainingEnemies -= 1
		path.add_child(newBat)

func add_tower(position):
	print("adding tower")
	var newTower = towerWeak.instantiate()
	newTower.position = position;
	towers.append(newTower)
	self.add_child(newTower)
