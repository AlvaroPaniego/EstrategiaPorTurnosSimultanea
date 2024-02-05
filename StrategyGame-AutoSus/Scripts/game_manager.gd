extends Node

#recursos actuales
var curFood : int = 0
var curMetal : int = 0
var curEnergy : int = 0
var curOxygen : int = 0

#recursos por turno
var foodPerTurn : int = 0
var metalPerTurn : int = 0
var energyPerTurn : int = 0
var oxygenPerTurn : int = 0

#contador turno
var turn : int = 1

#colocando edificio
var currentlyBuiding : bool = false

#tipo de edidficio
var buildingType : int 

var placingPath : bool = false

#cosas de las unidades
var unitList : Array

#moviendo unidad
var currentlyMoving : bool = false

#componentes
@onready var ui : Node = get_node("Camera2D/UI")
@onready var map : Node2D= get_node("Map")
var unit = preload("res://Scenes/unit.tscn")

func _ready():
	ui.update_resource_text()
	ui.on_end_turn()

func on_select_building(buildingType):
	self.buildingType = buildingType
	currentlyBuiding = true
	
	map.highlight_available_tiles()

func add_resource_per_turn(resource : Resources.Type, amount):
	match resource:
		Resources.Type.NOTHING:
			return
		Resources.Type.FOOD:
			foodPerTurn += amount
		Resources.Type.METAL:
			metalPerTurn += amount
		Resources.Type.OXYGEN:
			oxygenPerTurn += amount
		Resources.Type.ENERGY:
			energyPerTurn += amount

func place_building(tileToPlaceOn):
	currentlyBuiding = false
	
	var texture : Texture
	
	match buildingType:
		1:
			texture = BuildingData.mine.iconTexture
			add_resource_per_turn(BuildingData.mine.prodResourceType, BuildingData.mine.prodResourceAmount)
			add_resource_per_turn(BuildingData.mine.upkeepResourceType, BuildingData.mine.upkeepResourceAmount)
		2:
			texture = BuildingData.greenhouse.iconTexture
			add_resource_per_turn(BuildingData.greenhouse.prodResourceType, BuildingData.greenhouse.prodResourceAmount)
			add_resource_per_turn(BuildingData.greenhouse.upkeepResourceType, BuildingData.greenhouse.upkeepResourceAmount)
		3:
			texture = BuildingData.solarPanel.iconTexture
			add_resource_per_turn(BuildingData.solarPanel.prodResourceType, BuildingData.solarPanel.prodResourceAmount)
			add_resource_per_turn(BuildingData.solarPanel.upkeepResourceType, BuildingData.solarPanel.upkeepResourceAmount)
	
	map.place_building(tileToPlaceOn, texture)
	ui.update_resource_text()

func spawn_unit(pos, x, y, isEnemy):
	map = get_node("Map")
	var newUnit = unit.instantiate()
	if isEnemy:
		newUnit.unitIcon.texture = preload("res://Sprites/Units/Blue/infatry.png")
	newUnit.position = pos
	newUnit.x = x
	newUnit.y = y
	newUnit.isEnemy = isEnemy
	unitList.append(newUnit)
	map.add_child(newUnit)

func end_turn(): 
	curFood += foodPerTurn
	curEnergy += energyPerTurn
	curMetal += metalPerTurn
	curOxygen += oxygenPerTurn
	
	for units in unitList:
		units.set_path()
	
	map.disable_tile_collision_for_unit()
	
	turn += 1
