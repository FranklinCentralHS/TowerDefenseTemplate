extends CharacterBody2D


var speed = 100
var pathName = "Soldier A"
var bulletDamage
var target : Node2D

func _physics_process(delta):
	var pathSpawnerNode = get_tree().get_root().get_node("Main/PathSpawner")
	#for i in pathSpawnerNode.get_child_count():
	#	print(pathSpawnerNode.get_child(i).name)
	#	if pathSpawnerNode.get_child(i).name == pathName:
	#		target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position
	#if(target !=null):
	#	velocity = global_position.direction_to(target) * speed

	if(target != null):
		velocity = global_position.direction_to(target.global_position) * speed
		look_at(target.global_position)

		move_and_collide(velocity)
	else:
		queue_free()
	

func _on_area_2d_body_entered(body:Node2D):
	if body is Soldier:
		body.Health -= bulletDamage
		queue_free()

