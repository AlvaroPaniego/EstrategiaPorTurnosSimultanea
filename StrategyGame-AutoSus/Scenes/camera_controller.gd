extends Camera2D

var speed := 15

func _input(event):
	if event.is_action("palante"):
		position = position + Vector2.UP * speed
	elif event.is_action("patra"):
		position = position + Vector2.DOWN * speed
	elif event.is_action("paizq"):
		position = position + Vector2.LEFT * speed
	elif event.is_action("padrch"):
		position = position + Vector2.RIGHT * speed
	else:
		return
