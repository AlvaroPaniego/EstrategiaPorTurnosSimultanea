extends Node

var blueInfantry = Unit.new(Enums.UnitType.INFANTRY, preload("res://Sprites/Units/Blue/infantry.png"), Enums.Type.NOTHING, 0, Enums.Type.FOOD, 1)
var yellowInfantry = Unit.new(Enums.UnitType.INFANTRY, preload("res://Sprites/Units/Yellow/infantry.png"), Enums.Type.NOTHING, 0, Enums.Type.FOOD, 1)
var redInfantry = Unit.new(Enums.UnitType.INFANTRY, preload("res://Sprites/Units/Red/infantry.png"), Enums.Type.NOTHING, 0, Enums.Type.FOOD, 1)
var greenInfantry = Unit.new(Enums.UnitType.INFANTRY, preload("res://Sprites/Units/Green/infantry.png"), Enums.Type.NOTHING, 0, Enums.Type.FOOD, 1)

class Unit:
	enum Resources {NOTHING, METAL, ENERGY, FOOD}
	#tipo de edidficio
	var type : Enums.UnitType
	
	#textura del edificio
	var iconTexture : Texture
	
	#produccion del edificio
	var prodResourceType : Enums.Type
	var prodResourceAmount : int
	
	#mantebiniento del edificio
	var upkeepResourceType : Enums.Type
	var upkeepResourceAmount : int
	
	#constructor
	func _init(type, iconTexture, prodResourceType, prodResourceAmount, upkeepResourceType, upkeepResourceAmount):
		self.type = type
		self.iconTexture = iconTexture
		self.prodResourceType = prodResourceType
		self.prodResourceAmount = prodResourceAmount
		self.upkeepResourceType = upkeepResourceType
		self.upkeepResourceAmount = upkeepResourceAmount
