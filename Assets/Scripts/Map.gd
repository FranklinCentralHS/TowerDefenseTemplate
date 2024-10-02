extends TileMap

var game;

func _ready():
	game = get_parent().get_parent()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			game.add_tower(event.position)
