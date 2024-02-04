extends Control

#textos
@onready var foodMetalText : Node = get_node("Food-MetalText")
@onready var oxygenEnergyText : Node = get_node("Oxygen-EnergyText")
@onready var currentTurn : Node = get_node("TurnLabel")

#botones
@onready var buildingButtons : Node = get_node("BulidingButtons")
@onready var endTurnButton : Node = get_node("EndTunrnButton")

#managers (estan en el nodo principal)
@onready var gameManager : Node = get_node("/root/MainNode")

func on_end_turn():
	currentTurn.text = "Turn: " + str(gameManager.turn)
	buildingButtons.visible = true

func update_resource_text():
	var foodMetal = ""
	foodMetal += str(gameManager.curFood) + " (" + ("+" if gameManager.foodPerTurn >= 0 else "") + str(gameManager.foodPerTurn) + ")\n"
	foodMetal += str(gameManager.curMetal) + " (" + ("+" if gameManager.metalPerTurn >= 0 else "") + str(gameManager.metalPerTurn) + ")"
	
	foodMetalText.text = foodMetal
	
	var oxygenEnergy = ""
	oxygenEnergy += str(gameManager.curOxygen) + " (" + ("+" if gameManager.oxygenPerTurn >= 0 else "") + str(gameManager.oxygenPerTurn) + ")\n"
	oxygenEnergy += str(gameManager.curEnergy) + " (" + ("+" if gameManager.energyPerTurn >= 0 else "") + str(gameManager.energyPerTurn) + ")"
	
	oxygenEnergyText.text = oxygenEnergy


func _on_end_tunrn_button_pressed():
	gameManager.end_turn()
	on_end_turn()
	update_resource_text()


func _on_solar_panel_button_pressed():
	buildingButtons.visible = false
	gameManager.on_select_building(3)


func _on_green_house_button_pressed():
	buildingButtons.visible = false
	gameManager.on_select_building(2)

func _on_mine_button_pressed():
	buildingButtons.visible = false
	gameManager.on_select_building(1)
