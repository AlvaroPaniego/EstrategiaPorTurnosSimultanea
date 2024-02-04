extends Node
var base : Building = Building.new(0, preload("res://Sprites/Buildings/Buildings_kenny/Red/hq.png"), Resources.Type.NOTHING, 0, Resources.Type.NOTHING, 0)
var mine : Building = Building.new(1, preload("res://Sprites/Buildings/Buildings_kenny/Red/mine.png"), Resources.Type.METAL, 1, Resources.Type.ENERGY, -1)
var greenhouse : Building = Building.new(2, preload("res://Sprites/Buildings/Buildings_kenny/Red/farm.png"), Resources.Type.FOOD, 1, Resources.Type.NOTHING, 0)
var solarPanel : Building = Building.new(3, preload("res://Sprites/Buildings/Buildings_kenny/Red/energy_factory.png"), Resources.Type.ENERGY, 1, Resources.Type.NOTHING, 0)

class Building:
	enum Resources {NOTHING, METAL, ENERGY, FOOD}
	#tipo de edidficio
	var type : int
	
	#textura del edificio
	var iconTexture : Texture
	
	#produccion del edificio
	var prodResourceType : Resources.Type
	var prodResourceAmount : int
	
	#mantebiniento del edificio
	var upkeepResourceType : Resources.Type
	var upkeepResourceAmount : int
	
	#constructor
	func _init(type, iconTexture, prodResourceType, prodResourceAmount, upkeepResourceType, upkeepResourceAmount):
		self.type = type
		self.iconTexture = iconTexture
		self.prodResourceType = prodResourceType
		self.prodResourceAmount = prodResourceAmount
		self.upkeepResourceType = upkeepResourceType
		self.upkeepResourceAmount = upkeepResourceAmount
	
	func pepe() -> Texture:
		return iconTexture
