extends Control

@onready var health_points_tens = $Health_points_tens
@onready var health_points_units = $Health_points_tens/Health_points_units
@onready var color_rect = $ColorRect
var health_gradient = preload("res://Resources/Gradients/health_gradient.tres")
var total_health : float = 20
var health : float
var health_change : float = -2

var tens_frame : int
var units_frame : int

var gradient_point : float

func _ready():
	health = total_health
	gradient_point = health/total_health
	print(gradient_point)
	
	tens_frame = health/10
	units_frame = int(health)%10
	
	color_rect.color = health_gradient.sample(gradient_point)
	health_points_tens.frame = tens_frame
	health_points_units.frame = units_frame

func _input(event):
	if !event.is_action_pressed("ui_accept"): 
		return
	update_health()
func update_health():
	health += health_change
	gradient_point = health/total_health
	print(gradient_point)
	
	tens_frame = health/10
	units_frame = int(health)%10
	
	color_rect.color = health_gradient.sample(gradient_point)
	health_points_tens.frame = tens_frame
	health_points_units.frame = units_frame
