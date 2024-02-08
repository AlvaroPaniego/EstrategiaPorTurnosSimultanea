extends Node2D
@export var noise_texture : NoiseTexture2D
@onready var tile_map: TileMap = $TileMap
@onready var noise = noise_texture.noise

const width = 14
const height = 33

#terrain sets
const water_terrain_set = 0
const road_terrain_set = 1

#terrains
const water_terrain = 0
const ground_road_terrain = 0
const water_road_terrain = 1

#suelo
var ground_tiles = [Vector2i(0,0), Vector2i(1,0), Vector2i(2,0)]

#limite para poner una tile
@export var max_water = 0.2

var seed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seed = randi()
	generate_map(width, height)

func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("ui_accept"):
		return
	seed = randi()
	generate_map(width, height)
func generate_map(width, height):
	var tiles = []
	var noise_value
	noise.seed = seed
	for x in range(height):
		for y in range(width):
			noise_value = noise.get_noise_2d(x, y)
			print(str(noise_value) + " < " + str(max_water))
			if noise_value < max_water:
				tiles.append(Vector2(x,y))
			else: 
				tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(1, 2))
	
	tile_map.set_cells_terrain_connect(0, tiles,water_terrain_set, water_terrain)
