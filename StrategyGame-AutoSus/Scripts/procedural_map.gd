extends Node2D
@export var noise_texture : NoiseTexture2D
@onready var tile_map: TileMap = $TileMap
@onready var noise = noise_texture.noise

const map_width = 20
const map_height = 33

#terrain sets
const background_terrain_set = 0
const road_terrain_set = 1

#terrains
const water_terrain = 0
const ground_road_terrain = 0
const water_road_terrain = 1
const coastline_terrain = 1

#suelo
var ground_tiles = [Vector2i(0,0), Vector2i(1,0), Vector2i(2,0)]

#limite para poner una tile
@export var max_water : float = 0.15

var map_seed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map_seed = randi()
	generate_map()

func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("ui_accept"):
		return
	map_seed = randi()
	generate_map()
func generate_map():
	var tiles = []
	var noise_value
	noise.seed = map_seed
	for x in range(map_height):
		for y in range(map_width):
			noise_value = noise.get_noise_2d(x, y)
			if noise_value <= max_water:
				tiles.append(Vector2(x,y))
			else: 
				pass
#				tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(1 ,2))
	
	tile_map.set_cells_terrain_connect(0, tiles,background_terrain_set, coastline_terrain)
