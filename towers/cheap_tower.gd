extends StaticBody2D


var bullet : PackedScene = preload("res://towers/red_bullet.tscn")
var bulletDamage = 5
var pathName
var currTargets = []
var curr

func _process(delta):
	if is_instance_valid(curr):
		self.look_at(curr.global_position)

func _on_tower_body_entered(body):
	if "Slime A" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()

		for target in currTargets:
			if "Slime" in target.name:
				tempArray.append(target)

		var currTarget = null
				
		for i in tempArray:
			if currTarget == null:
				currTarget = i
			else:
				if i.get_parent().get_progress() > currTarget.get_parent().get_progress():
					currTarget = i

		print(currTarget.get_class())
		curr = currTargets
		pathName = currTarget.get_parent().name
		
		var tempBullet  = bullet.instantiate()
		tempBullet.bulletDamage = bulletDamage
		tempBullet.target = currTarget
		get_node("BulletContainer").call_deferred("add_child",tempBullet)
		tempBullet.global_position = $Aim.global_position

func _on_tower_body_exited(body):
	currTargets = get_node("Tower").get_overlapping_bodies()