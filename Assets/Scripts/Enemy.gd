extends characterBody2D
class_name Enemy
#all Enemy's will have this provided they have [extends Enemy]

#variables
#@export creates visability in the inspector in scenes that use them
@export var hp = 10
@export var speed = 50
@export var damage = 10
@export var canFly = "false"
@export var Name = "enemy"
@export var canBeHit ="true" 

#movement math finds shortest path to the end and takes it
var accel = 7
@onready var nav: NavigationAgent2D = $NavigationAgent2D
func _process(delta):
	var direction = Vector3()
	nav.target_position = Vector2(1250, 477)

	direction = nav.get_next_path_position()-global_position
	direction =direction.normalized()
	
	velocity = velocity.lerp(direction*speed*2,accel*delta)
	move_and_slide()
