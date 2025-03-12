class_name NPC

extends Node2D

@export var sellerName: String
@export var profession: String
@onready var instructionText = $DialogBlock/InstructionObject
@onready var gameNode = get_parent()
@onready var dialogComponet = $DialogBlock
@onready var dialogPeice = $DialogBlock/Dialog
@onready var yesAndNoBTN = $DialogBlock/DialogButtons1
@onready var okBtn = $DialogBlock/DialogButtons2
@onready var actionSelectMenu = $DialogBlock/DialogSelectMenu
@onready var dialogText = $DialogBlock/Dialog/Sprite2D/DialogText
var player

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		body.nextToBoatGuy = true
		dialogComponet.visible = true
		gameNode.changeVisibility(instructionText,true)
		
func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.nextToBoatGuy = false
		gameNode.changeVisibility(dialogComponet,false)
		


func _on_game_talking_with_boat_guy() -> void:
	gameNode.changeVisibility(actionSelectMenu,true)
	gameNode.changeVisibility(instructionText,false)


func _on_dialog_select_menu_action_selected(action: String) -> void:
	if action == "quest":
		pass
	elif action == "talk":
		talkingWithBoatGuy()
	else:
		closeInteraction()
		
		
		
func talkingWithBoatGuy():
	gameNode.changeVisibility(actionSelectMenu,false)
	gameNode.changeVisibility(dialogPeice,true)
	if gameNode.boatOwned:
		dialogText.text = "Go to the end of the dock to get in the boat."
		gameNode.changeVisibility(okBtn,true)
	else:
		dialogText.text = "Hello "+ player.playerName+", would you like to buy a boat for $500?"
		gameNode.changeVisibility(yesAndNoBTN,true)
		 
	
func closeInteraction():
	gameNode.changeVisibility(dialogComponet,false)
	dialogComponet.visible = true
	gameNode.changeVisibility(instructionText,true)


func _on_yes_pressed() -> void:
	if player.money >= 500:
		dialogText.text = "Ok, here is the key. Go to the end of the dock to get in the boat."
		gameNode.boatOwned = true
	else:
		dialogText.text = "You do not have enough money to buy this boat."
		
	gameNode.changeVisibility(yesAndNoBTN,false)
	gameNode.changeVisibility(okBtn,true)
		


func _on_no_pressed() -> void:
	closeInteraction()


func _on_ok_pressed() -> void:
	closeInteraction()
