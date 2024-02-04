extends Node

var astar_grid : = AStarGrid2D.new()
@onready var tileMap = $"../TileMap"
var line := Line2D.new()

var idStart: Vector2i
var idEnd: Vector2i

var firstTileSelected : bool = false

var offset := 8

func _ready() -> void:
	create_AGrid()
	create_line()

func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("left_mouse_click"):
		return
	print("ha pasao algo")
	if !firstTileSelected:
		line.clear_points()
		print(tileMap.local_to_map(event.position))
		idStart = tileMap.local_to_map(event.position)
		print(idStart)
		firstTileSelected = true
	else:
		print(tileMap.local_to_map(event.position))
		idEnd = tileMap.local_to_map(event.position)
		print(idEnd)
		firstTileSelected = false
		paint_line()

func create_AGrid():
	astar_grid.region = tileMap.get_used_rect()
	astar_grid.cell_size = Vector2(16,16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()

func create_line():
	line.z_index = 1
	line.width = 2.5
	line.default_color = Color.BLUE_VIOLET
	tileMap.add_child(line)

func paint_line(): 
	if idStart == idEnd:
		print("Misma posicion")
		return
	var path = astar_grid.get_id_path(idStart, idEnd)
	#cambiar 5 por el movimiento de la unidad (+1 porque tambien cuenta la posicion de la unidad)
	#if path.size() > 5:
	#	path.resize(5)

	for point in path:
		var pos = astar_grid.get_point_position(point)
		print(str(pos.x + offset) + ", " + str(pos.y + offset))
		line.add_point(Vector2(pos.x + offset, pos.y + offset))
