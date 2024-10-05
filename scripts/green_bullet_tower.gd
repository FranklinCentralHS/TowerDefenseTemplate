extends Tower


func _process(delta):
	if is_instance_valid(curr):
		self.look_at(curr.global_position)
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(1)




func _on_range_body_entered(body):
	if "Soldier A" in body.name:
		var tempArray = []
		currTargets = get_node("Range").get_overlapping_bodies()

		for i in currTargets:
			if "Soldier A" in i.name:
				tempArray.append(i)

		var currTarget = null

		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")

		curr = currTarget
		pathName = currTarget.get_parent().name

		var tempBullet = bullet.instantiate()

		tempBullet.target = currTarget
		
		#tempBullet.pathName = pathName
		tempBullet.bulletDamage = bulletDamage
		var bulletContainer = get_node("BulletContainer")
		bulletContainer.call_deferred("add_child", tempBullet)
		tempBullet.global_position = $Aim.global_position



func _on_range_body_exited(body):
	currTargets = get_node("Range").get_overlapping_bodies()
