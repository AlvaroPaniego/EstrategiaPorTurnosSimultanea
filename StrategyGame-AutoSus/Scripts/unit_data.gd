extends Node

#var blueInfantry = Unit.new()

class Unit:
	enum Resources {NOTHING, METAL, ENERGY, FOOD}
	enum UnitType {INFANTRY, ARMORED_TRANSPORT, CHOPPER, FIGHTER, LOGI_TRUCK, MISSILE_TRUCK,
					ROCKET_INFANTRY, SUBMARINE, TANK, TRANSPORT_BOAT, TRANSPORT_CHOPPER,
					TRANSPORT_TRUCK, WARSHIP
				}
	#tipo de edidficio
	var type : UnitType
	
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
