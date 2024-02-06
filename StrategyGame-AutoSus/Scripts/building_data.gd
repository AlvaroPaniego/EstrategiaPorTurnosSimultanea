extends Node
var base : Building = Building.new(0, preload("res://Sprites/Buildings/Buildings_kenny/Red/hq.png"), Enums.Type.NOTHING, 0, Enums.Type.NOTHING, 0)
var mine : Building = Building.new(1, preload("res://Sprites/Buildings/Buildings_kenny/Red/mine.png"), Enums.Type.METAL, 1, Enums.Type.ENERGY, -1)
var greenhouse : Building = Building.new(2, preload("res://Sprites/Buildings/Buildings_kenny/Red/farm.png"), Enums.Type.FOOD, 1, Enums.Type.NOTHING, 0)
var solarPanel : Building = Building.new(3, preload("res://Sprites/Buildings/Buildings_kenny/Red/energy_factory.png"), Enums.Type.ENERGY, 1, Enums.Type.NOTHING, 0)

class Building:
	enum Resources {NOTHING, METAL, ENERGY, FOOD}
	#tipo de edidficio
	var type : int
	
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
