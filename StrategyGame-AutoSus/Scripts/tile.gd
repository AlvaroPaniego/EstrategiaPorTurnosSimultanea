extends Area2D

@export var startTile : bool = false;
var hasBuilding : bool = false;
var canPlaceBuilding : bool = false;
var x : int = 0
var y : int = 0

#Components
#El @onready hace que la variable se inicialize cuando cargue la escena
@onready var highlight : Sprite2D  = get_node("Highlight");
@onready var buildingIcon : Sprite2D  = get_node("BuildingIcon");

func toggle_highlight(toggle): 
		highlight.visible = toggle;
		canPlaceBuilding = toggle;

func place_building(buildingTexture):
	hasBuilding = true;
	buildingIcon.texture = buildingTexture;

#eventos
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var gameManager : Node = get_node("/root/MainNode")
		var pathManager : Node = get_node("/root/MainNode/Tiles/Pathfinding")
		if gameManager.currentlyBuiding and canPlaceBuilding and !gameManager.placingPath:
			#print("has colocado una cosita")
			gameManager.place_building(self)
		#if !pathManager.finalizePathSearch and !gameManager.currentlyBuiding and !hasBuilding:
		#	#print("estas colocando el origen")
		#	gameManager.placingPath = true
		#	pathManager.set_idStart(Vector2i(x, y))
		#elif !hasBuilding:
		#	#print("estas colocando el final")
		#	gameManager.placingPath = false
		#	pathManager.set_idEnd(Vector2i(x, y))
		#	pathManager.get_path_coordinates()
