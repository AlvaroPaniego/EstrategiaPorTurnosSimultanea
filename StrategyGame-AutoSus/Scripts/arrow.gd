extends Node2D

@onready var arrow: Node2D = get_node(".")
var spriteArrow : Array[Sprite2D]
#var arrowPath : Array[Vector2] = [Vector2(16, 16), Vector2(16, 32), Vector2(16, 48), Vector2(16, 64), Vector2(16, 80)]

var down_arrow = preload("res://Sprites/Misc/down_arrow.png")
var down_to_left = preload("res://Sprites/Misc/down_to_left.png") 
var down_to_right = preload("res://Sprites/Misc/down_to_right.png")
var horizontal = preload("res://Sprites/Misc/horizontal.png")
var left_arrow = preload("res://Sprites/Misc/left_arrow.png")
var right_arrow = preload("res://Sprites/Misc/right_arrow.png")
var up_arrow = preload("res://Sprites/Misc/up_arrow.png")
var up_to_left = preload("res://Sprites/Misc/up_to_left.png")
var up_to_right = preload("res://Sprites/Misc/up_to_right.png")
var vertical = preload("res://Sprites/Misc/vertical.png")

func _init() -> void:
	print(arrow)
	#paint_arrow([Vector2(16, 16), Vector2(16, 32), Vector2(16, 48), Vector2(16, 64), Vector2(16, 80)])
	#print(arrowPath)

func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("left_mouse_click"):
		return
	delete_arrow()

func delete_arrow():
	#arrowPath.clear()
	for sprite in spriteArrow:
		sprite.texture = null
	spriteArrow.clear()

func paint_arrow(arrowPath):
	#print(arrow)
	print(arrowPath)
	#print(arrowPath.size())
	var newSprite
	print(arrowPath.size())
	for pos in range(arrowPath.size()-1):
		#print(pos)
		newSprite = Sprite2D.new()
		if pos == 0:
			choose_starting_direction(arrowPath[pos], arrowPath[pos+1], newSprite)
		else:
			choose_direction(arrowPath[pos-1], arrowPath[pos], arrowPath[pos+1], newSprite)
		newSprite.position = arrowPath[pos]
		#print(str(newSprite.texture) + " " + str(newSprite.position))
		spriteArrow.append(newSprite)
		arrow.add_child(newSprite)
	newSprite = Sprite2D.new()
	choose_ending_direction(arrowPath[arrowPath.size()-1], arrowPath[arrowPath.size()-2], newSprite)
	newSprite.position = arrowPath[arrowPath.size()-1]
	#print(str(newSprite.texture) + " " + str(newSprite.position))
	spriteArrow.append(newSprite)
	arrow.add_child(newSprite)
	print(arrow.get_children())

func choose_starting_direction(pos, nextPos, newSprite):
	var horizontalMove = abs(nextPos.x - pos.x) != 0
	var verticalMove = abs(nextPos.y - pos.y) != 0
	
	newSprite.z_index = 1
	
	if horizontalMove:
		newSprite.texture = horizontal
	elif verticalMove:
		newSprite.texture = vertical

func choose_ending_direction(pos, prevPos, newSprite):
	var horizontalMove = abs(pos.x - prevPos.x) != 0
	var verticalMove = abs(pos.y - prevPos.y) != 0
	
	newSprite.z_index = 1
	
	if horizontalMove:
		if pos.x - prevPos.x < 0:
			newSprite.texture = left_arrow
		else:
			newSprite.texture = right_arrow
	elif verticalMove:
		if pos.y - prevPos.y < 0:
			newSprite.texture = up_arrow
		else:
			newSprite.texture = down_arrow

func choose_direction(prevPos, pos, nextPos, newSprite):
	var nextHorizontal = abs(nextPos.x - pos.x) != 0
	var nextVertical = abs(nextPos.y - pos.y) != 0
	var prevHorizontal = abs(pos.x - prevPos.x) != 0
	var prevVertical = abs(pos.y - prevPos.y) != 0
	
	newSprite.z_index = 1
	
	#print("prevPos: " + str(prevPos) + " pos: " + str(pos) + " nextPos" + str(nextPos))
	#
	#print("prevVertical: " + str(prevVertical))
	#print("prevHorizontal: " + str(prevHorizontal))
	#
	#print("nextVertical: " + str(nextVertical))
	#print("nextHorizontal: " + str(nextHorizontal))
	
	
	if prevHorizontal and nextHorizontal:
		newSprite.texture = horizontal
	elif prevHorizontal and nextVertical:
		#print(str(nextPos.y - pos.y))
		if nextPos.y - pos.y > 0:
			#print(str(pos.x - prevPos.x))
			if pos.x - prevPos.x <= 0:
				newSprite.texture = down_to_right 
			else:
				newSprite.texture = down_to_left
		else:
			if pos.x - prevPos.x <= 0:
				newSprite.texture = up_to_right
			else:
				newSprite.texture = up_to_left
	elif prevVertical and nextVertical:
		newSprite.texture = vertical
	elif prevVertical and nextHorizontal:
		#print(str(nextPos.x - pos.x))
		if nextPos.x - pos.x > 0:
			#print(str(pos.y - prevPos.y))
			if pos.y - prevPos.y <= 0:
				newSprite.texture = down_to_right
			else:
				newSprite.texture = up_to_right
		else:
			if pos.y - prevPos.y <= 0:
				newSprite.texture = down_to_left
			else:
				newSprite.texture = up_to_left
	else:
		print("Faltan condiciones")
