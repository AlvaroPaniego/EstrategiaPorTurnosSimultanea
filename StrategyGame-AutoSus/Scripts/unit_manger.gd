extends Node

@onready var pathManager : Node = get_node("/root/MainNode/Map/Patfinding")
@onready var map: Node2D = $"../Map"


var unit = preload("res://Scenes/unit.tscn")

#cosas de las unidades
var unitList : Array
var selectedUnit
var i = 0


func spawn_unit(pos, x, y, isEnemy):
	map = $"../Map"
	var newUnit = unit.instantiate()
	map.add_child(newUnit)
	if isEnemy:
		print(newUnit.unitIcon)
		newUnit.set_texture(UnitData.blueInfantry.iconTexture)
	else:
		print(newUnit.unitIcon)
		newUnit.set_texture(UnitData.greenInfantry.iconTexture)
	newUnit.position = pos
	newUnit.x = x
	newUnit.y = y
	newUnit.isEnemy = isEnemy
	unitList.append(newUnit)

func set_path():
	var path = pathManager.get_final_path()
	selectedUnit.set_path(path)
	if selectedUnit.path == null:
		return
	print("poniendo camino para : " + str(selectedUnit))
	var pos = pathManager.idEnd
	map.get_tile(selectedUnit.position).hasUnit = false
	selectedUnit.x = pos.x
	selectedUnit.y = pos.y
	selectedUnit.finalPos = selectedUnit.path[selectedUnit.path.size()-1]
	map.get_tile(selectedUnit.path[selectedUnit.path.size()-1]).hasUnit = true

func set_start_of_path():
	#print(selectedUnit)
	pathManager.set_idStart(Vector2i(selectedUnit.x, selectedUnit.y))

func set_end_of_path(x, y):
	#print(selectedUnit)
	pathManager.set_idEnd(Vector2i(x, y))

func end_turn():
	for units in unitList:
		print(str(units) + " camino unidad: " + str(units.path) + " camino flecha: " + str(units.path))
		
		if !units.path.is_empty():
			units.canMove = true
	
	map.disable_tile_collision_for_unit()
