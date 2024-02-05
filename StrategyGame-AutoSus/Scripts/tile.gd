extends Area2D

@export var startTile : bool = false;
var hasBuilding : bool = false;
var hasUnit : bool = false;
var canPlaceBuilding : bool = false;
var x : int = 0
var y : int = 0



#Components
#El @onready hace que la variable se inicialize cuando cargue la escena
@onready var highlight : Sprite2D  = get_node("Highlight");
@onready var buildingIcon : Sprite2D  = get_node("BuildingIcon");
@onready var collision : CollisionShape2D = get_node("CollisionShape2D")

func toggle_highlight(toggle): 
		highlight.visible = toggle;
		canPlaceBuilding = toggle;

func place_building(buildingTexture):
	hasBuilding = true;
	buildingIcon.texture = buildingTexture;

func set_color(color):
	highlight.modulate = color

func toggle_collision(toggle):
	collision.visible = toggle

#eventos
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var gameManager : Node = get_node("/root/MainNode")
		var pathManager : Node = get_node("/root/MainNode/Map/Patfinding")
		if gameManager.currentlyBuiding and canPlaceBuilding and !gameManager.placingPath:
			print("has colocado una cosita")
			gameManager.place_building(self)
		if !hasBuilding and !hasUnit:
			print("estas colocando el final")
			gameManager.placingPath = false
			gameManager.map.disable_all_tile_highlights()
			pathManager.set_idEnd(Vector2i(x, y))
