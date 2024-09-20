extends Node3D

@export var tile_straight:PackedScene
@export var tile_corner:PackedScene
@export var tile_empty:PackedScene


@export var map_length:int = 16
@export var map_height:int = 9

var _pg:PathGenerator

# Called when the node enters the scene tree for the first time.
func _ready():
	_pg = PathGenerator.new(map_length, map_height)
	_display_path()


func _display_path():
	var _path:Array[Vector2i] = _pg.generate_path()
	
	while _path.size() < 35:
		_path = _pg.generate_path()


	print(_path)
	for element in _path:
		var tile_score:int = _pg.get_tile_score(element)
		var tile:Node3D = tile_empty.instantiate()
		var tile_rotation: Vector3 = Vector3.ZERO
		if tile_score == 2 or tile_score == 8 or tile_score == 10:
			tile = tile_straight.instantiate()
			tile_rotation = Vector3(0,90,0)

		add_child(tile)
		tile.global_position = Vector3(element.x, 0, element.y)
