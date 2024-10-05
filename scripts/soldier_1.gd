extends CharacterBody2D
class_name Soldier

@export var speed : float = 100
var Health = 10
var time_in_seconds = 1
var can_spawn = true

func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)

	if get_parent().get_progress_ratio() == 1:
		get_tree().quit()
		print("game over")
	if Health <= 0:
		get_parent().get_parent().queue_free()

