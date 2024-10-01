extends Area2D


#Ends game if 1100 damage in enemies gets trough
var health=100

func _on_body_entered(body):
	health-=body.damage
	if health<=0:
		get_tree().change_scene_to_file("res://Scenes/dead.tscn")
