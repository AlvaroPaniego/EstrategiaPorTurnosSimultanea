extends Area2D
var hasMoved : bool = false
var isEnemy : bool = false
var x : int = 0
var y : int = 0
@onready var map : Node = get_node("/root/MainNode/Map")
@onready var pathManager : Node = get_node("/root/MainNode/Map/Patfinding")
@onready var unitIcon: Sprite2D = $Sprite2D

var path : Array[Vector2]
@export var speed : = 10
var current_point_index = 0
var finalPos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 1

func set_path():
	path = pathManager.get_final_path()
	if path == null:
		return
	var pos = pathManager.idEnd
	map.get_tile(position).hasUnit = false
	x = pos.x
	y = pos.y
	finalPos = path[path.size()-1]
	map.get_tile(path[path.size()-1]).hasUnit = true

func _process(delta: float) -> void:
	if path.is_empty():
		return
	move(delta)

func move(delta):
	if position.distance_to(path[current_point_index]) < speed * delta:
		current_point_index += 1
		if current_point_index >= path.size():
			current_point_index = 0
			path.clear()
	if !path.is_empty():
		position = position.lerp(path[current_point_index], speed * delta)
	if path.size() == 0:
		position = finalPos

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		var gameManager : Node = get_node("/root/MainNode")
		
		print("Has pinchao en una unidad")
		if !gameManager.currentlyBuiding and !hasMoved:
			map.show_movement_range(Vector2(x, y), 5)
			print("seleccionada para mover")
			pathManager.set_idStart(Vector2i(x, y))
