extends StaticBody2D
class_name Tower
#all towers have this assuming they have [extends Tower]



var bullet = preload("res://Scenes/bullet.tscn")

#variables
#@export creates visability in the inspector in scenes that use them
@export var range = 10
@export var fireRate = 1
@export var power = 10
@export var cost = 10	

var enemies:Array[Enemy] = []
var targetEnemy:Enemy = null

func _ready():
	var timer:Timer = self.get_node("FireTimer")
	timer.wait_time = fireRate
	
func find_target():
	if targetEnemy == null and len(enemies) > 0:
		targetEnemy = enemies[0]

func _on_tower_area_entered(area):
	if area.name == "Bat":
		var enemy = area.get_parent()
		enemies.append(enemy)
	
	self.find_target()
	

func _on_tower_area_exited(area):
	if area.name == "Bat":
		var enemy = area.get_parent()
		var position = enemies.find(enemy)
		if position > -1:
			enemies.remove_at(position)
		targetEnemy = null
			
	self.find_target()

func _on_fire_timer_timeout():
	if targetEnemy != null:
		var newBullet:CharacterBody2D = bullet.instantiate()
		newBullet.position = self.position
		
		#Vector2 offsettedTarget = targetEnemy.position + targetEnemy.Transform.X * 50f;
			#Vector2 velocity = (offsettedTarget - Position).Normalized();
		newBullet.velocity = (targetEnemy.position - self.position).normalized() * 200;
		get_node("/root").add_child(newBullet)		
		print("Fire!")
