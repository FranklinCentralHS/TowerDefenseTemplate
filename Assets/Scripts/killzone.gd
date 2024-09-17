extends Area2D

var health=GlobalVariable.health

func _on_body_entered(body):
	health-=body.damage
	if health<=0:
		get_tree().change_scene_to_file("res://Scenes/dead.tscn")
