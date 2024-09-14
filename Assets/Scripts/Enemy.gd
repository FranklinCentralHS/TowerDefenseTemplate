extends CharacterBody2D
class_name Enemy
#all Enemy's will have this
@export var hp = 10
@export var speed = 10
@export var damage = 10
@export var canFly = "false"
@export var Name = "enemy"
@export var canBeHit ="false"
func checkIsDead():
	if hp<=0:
		
	
