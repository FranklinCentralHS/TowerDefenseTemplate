extends CharacterBody2D
class_name Bullet

var Speed = 10
var pathName = ""
var bulletDamage : int
var target : Node2D = null

func _physics_process(delta):
	var pathSpawnerNode = get_tree().get_root().get_node("Level/PathSpawner")
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).get_child(0).global_position

	if(target !=null):
		velocity = global_position.direction_to(target.global_position) *Speed

		look_at(target.global_position)

		move_and_collide(velocity)
	
	else:
		queue_free()




func _on_area_2d_body_entered(body):
	if "Slime A" in body.name:
		body.health -= bulletDamage
		queue_free()
