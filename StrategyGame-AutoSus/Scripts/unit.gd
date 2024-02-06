extends Area2D
var isEnemy : bool = false
var canMove : bool = false
var x : int = 0
var y : int = 0
@onready var map : Node = get_node("/root/MainNode/Map")
@onready var unitIcon: Sprite2D = $Sprite2D
@onready var arrow: Node2D = $Arrow

var path : Array[Vector2]
@export var speed : = 10
var current_point_index = 0
var finalPos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 1
	arrow.z_index = 1

func _process(delta: float) -> void:
	if path.is_empty() and !canMove:
		return
	move(delta)

func move(delta):
	if !canMove: 
		return
	print("moviendose")
	if position.distance_to(path[current_point_index]) < speed * delta:
		current_point_index += 1
		if current_point_index >= path.size():
			current_point_index = 0
			path.clear()
	if !path.is_empty():
		position = position.lerp(path[current_point_index], speed * delta)
	if path.size() == 0:
		position = finalPos
		canMove = false
		arrow.delete_arrow()

func set_path(pathToFollow):
	path = pathToFollow
	#arrow.arrowPath = pathToFollow
	#arrow.paint_arrow()
	print(str(arrow.arrowPath) + " + " + str(path))

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		var gameManager : Node = get_node("/root/MainNode")
		var unitManager : Node = get_node("/root/MainNode/UnitManager")
		
		print("Has pinchao en una unidad")
		if !gameManager.currentlyBuiding:
			map.show_movement_range(Vector2(x, y), 5)
			unitManager.selectedUnit = self
			unitManager.set_start_of_path()
			print("seleccionada para mover")
