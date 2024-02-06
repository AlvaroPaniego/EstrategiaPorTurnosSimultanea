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

#moviendo unidad
var currentlyMoving : bool = false

#componentes
@onready var ui : Node = get_node("Camera2D/UI")
@onready var map : Node2D= get_node("Map")
@onready var unit_manager: Node = $UnitManager

func _ready():
	ui.update_resource_text()
	ui.on_end_turn()

func on_select_building(buildingType):
	self.buildingType = buildingType
	currentlyBuiding = true
	
	map.highlight_available_tiles()

func add_resource_per_turn(resource : Enums.Type, amount):
	match resource:
		Enums.Type.NOTHING:
			return
		Enums.Type.FOOD:
			foodPerTurn += amount
		Enums.Type.METAL:
			metalPerTurn += amount
		Enums.Type.OXYGEN:
			oxygenPerTurn += amount
		Enums.Type.ENERGY:
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

func end_turn(): 
	curFood += foodPerTurn
	curEnergy += energyPerTurn
	curMetal += metalPerTurn
	curOxygen += oxygenPerTurn
	
	unit_manager.end_turn()
	
	turn += 1
