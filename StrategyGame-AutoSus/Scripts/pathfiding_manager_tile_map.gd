extends Node

var astar_grid : = AStarGrid2D.new()
@onready var tileMap = $"../TileMap"
@onready var line := $"../Line2D"

var idStart: Vector2i
var idEnd: Vector2i

var firstTileSelected : bool = false

var offset := 8

signal path_chosen

func _ready() -> void:
	create_AGrid()
	create_line()

#func _input(event: InputEvent) -> void:
#	if !event.is_action_pressed("left_mouse_click"):
#		return
#	print("ha pasao algo")
#	if !firstTileSelected:
#		
#		print(tileMap.local_to_map(event.position))
#		idStart = tileMap.local_to_map(event.position)
#		print(idStart)
#		firstTileSelected = true
#	else:
#		print(tileMap.local_to_map(event.position))
#		idEnd = tileMap.local_to_map(event.position)
#		print(idEnd)
#		firstTileSelected = false
#		paint_line()

func create_AGrid():
	astar_grid.region = tileMap.get_used_rect()
	astar_grid.cell_size = Vector2(16,16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()

func create_line():
	line.z_index = 1
	line.width = 2.5

func get_final_path(): 
	var positionList : Array[Vector2]
	print("Inicio: " + str(idStart) + " Final: " + str(idEnd))
	if idStart == idEnd:
		#print("selecciona una unidad para moverla")
		return
	if !firstTileSelected:
		return
	var path = astar_grid.get_id_path(idStart, idEnd)

	for point in path:
		var pos = astar_grid.get_point_position(point)
		positionList.append(Vector2(pos.x + offset, pos.y + offset))
	firstTileSelected = false
	return positionList

func set_idStart(value):
	line.clear_points()
	idStart = value
	firstTileSelected = true
	print(firstTileSelected)
	

func paint_line_path():
	var path = astar_grid.get_id_path(idStart, idEnd)

	for point in path:
		var pos = astar_grid.get_point_position(point)
		line.add_point(Vector2(pos.x + offset, pos.y + offset))

func set_idEnd(value):
	if !firstTileSelected:
		print("selecciona una unidad para moverla")
		firstTileSelected = false
		return
	print(value.x - idStart.x)
	print(value.y - idStart.y)
	if abs(value.x - idStart.x) >= 5 or abs(value.y - idStart.y) >= 5:
		print("casilla fuera de alcanze")
		firstTileSelected = false
		return
	idEnd = value
	paint_line_path()
	path_chosen.emit()
