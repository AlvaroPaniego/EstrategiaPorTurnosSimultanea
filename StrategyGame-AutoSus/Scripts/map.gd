extends Node

var allTiles : Dictionary
var tilesWithBuildings : Array
@export var tileSize : float

var offset

#tile que se va a usar en el mapa
var tile = preload("res://Scenes/tile.tscn")

#nodo donde se añaden las tiles
@onready var grid : Node = get_node(".")

#Se ejecuta cuando se inicializa el nodo
func _ready():
	offset = tileSize/2
	print(offset)
	create_tile_grid(9, 20)
	
	for i in allTiles:
		if allTiles[i].startTile == true:
			place_building(allTiles[i], BuildingData.base.iconTexture)

func get_tile_at_position(position):
	for x in allTiles:
		#comprueba que la tile es valida para construir
		if allTiles[x].position == position and allTiles[x].hasBuilding == false:
			return allTiles[x]
	
	return null

func disable_all_tile_highlights():
	for x in allTiles:
		allTiles[x].toggle_highlight(false)

func highlight_available_tiles():
	for x in range(tilesWithBuildings.size()):
		var upTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(0.0, tileSize))
		var downTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(0.0, -tileSize))
		var leftTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(-tileSize, 0.0))
		var rightTile = get_tile_at_position(tilesWithBuildings[x].position + Vector2(tileSize, 0.0))
		
		if upTile != null:
			upTile.toggle_highlight(true) 
		if downTile != null:
			downTile.toggle_highlight(true) 
		if leftTile != null:
			leftTile.toggle_highlight(true) 
		if rightTile != null:
			rightTile.toggle_highlight(true)

#pa colocar edifcios
func place_building(tile, texture):
	tilesWithBuildings.append(tile)
	tile.place_building(texture)
	disable_all_tile_highlights()

#rellenar el grid con las tiles y los nodos del A*
func create_tile_grid(width, height):
	print(offset)
	var baseY : int = randi() % 10
	var baseX : int = randi() % 21
	for y in range(width):
		for x in range(height):
			var pos : Vector2 = Vector2(((tileSize*x)+offset), ((tileSize*y)+offset))
			var newTile = tile.instantiate()
			newTile.position = pos
			newTile.x = x
			newTile.y = y
			if x == baseX and y == baseY:
				newTile.startTile = true
			grid.add_child(newTile)
			
			allTiles[Vector2(x,y)] = newTile

