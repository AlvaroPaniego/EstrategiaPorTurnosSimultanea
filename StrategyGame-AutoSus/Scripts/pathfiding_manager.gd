extends Node

#datos de la tile y mapa
var tileSize : float = 64
var offset := tileSize/2
var width = 9
var height = 20

var finalizePathSearch : bool = false

var idStart: Vector2i
var idEnd: Vector2i

#Grid para poder usar el algoritmo A*
var astar_grid = AStarGrid2D.new()

#nodo donde se pinta la linea
@onready var grid = get_node(".")

#linea
var line : Line2D = Line2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_AGrid()

func create_AGrid():
	astar_grid.region = Rect2i(0, 0, height*tileSize, width*tileSize)
	astar_grid.cell_size = Vector2(tileSize,tileSize)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	line.z_index = 1
	grid.add_child(line)

func get_path_coordinates():
	var path = astar_grid.get_id_path(idStart, idEnd)
	#cambiar 5 por el movimiento de la unidad (+1 porque tambien cuenta la posicion de la unidad)
	if path.size() > 5:
		path.resize(5)

	for point in path:
		var pos = astar_grid.get_point_position(point)
		print(str(pos.x + offset) + ", " + str(pos.y + offset))
		line.add_point(Vector2(pos.x+offset, pos.y+offset))
	

func set_idStart(newidStart):
	line.clear_points()
	idStart = newidStart
	finalizePathSearch = true


func set_idEnd(newidEnd):
	idEnd = newidEnd 
	finalizePathSearch = false


