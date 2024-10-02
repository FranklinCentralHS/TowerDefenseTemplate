extends PathFollow2D
class_name Enemy
#all Enemy's will have this provided they have [extends Enemy]

#variables
#@export creates visability in the inspector in scenes that use them
@export var hp = 10
@export var speed = 50
@export var damage = 10

func _process(delta):
	self.set_progress(self.get_progress() + self.speed * delta)

	if self.progress_ratio > 0.99:
		print("remove enemy")
		self.get_parent().remove_child(self)


func _on_bat_area_entered(area):
	if area.name == "Bullet":
		var parent = self.get_parent()
		if parent != null:
			parent.remove_child(self)

	print(area.name)
