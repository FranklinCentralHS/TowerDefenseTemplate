extends Area2D

var health=100

func _on_body_entered(_body):
	health-=10
	if health<=0:
		get_tree().change_scene_to_file("res://Scenes/dead.tscn")
