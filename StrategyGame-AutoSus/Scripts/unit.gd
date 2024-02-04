extends Area2D
var hasMoved : bool = false;
var x : int = 0
var y : int = 0
@onready var map : Node = get_node("/root/MainNode/Map")
@onready var pathManager : Node = get_node("/root/MainNode/Map/Patfinding")
@onready var unitIcon: Sprite2D = $Sprite2D

var path : Array[Vector2]
@export var speed : = 10
var current_point_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 1
	#pathManager.path_chosen.connect(set_path)

func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("ui_accept"):
		return
	position = Vector2(16, 16)

func set_path():
	var pos = pathManager.idEnd
	for i in pathManager.get_final_path():
		path.append(i)
	x = pos.x
	y = pos.y

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

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		var gameManager : Node = get_node("/root/MainNode")
		
		print("Has pinchao en una unidad")
		if !gameManager.currentlyBuiding and !hasMoved:
			print("seleccionada para mover")
			pathManager.set_idStart(Vector2i(x, y))
