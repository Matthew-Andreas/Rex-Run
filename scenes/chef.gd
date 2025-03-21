class_name basicNPC

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
@onready var dialogText = $DialogBlock/Dialog/DialogText
var player

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		body.nextToChef = true
		dialogComponet.visible = true
		gameNode.changeVisibility(instructionText,true)
		
func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.nextToChef = false
		gameNode.changeVisibility(dialogComponet,false)
		


func _on_game_talking_with_chef() -> void:
	gameNode.changeVisibility(actionSelectMenu,true)
	gameNode.changeVisibility(instructionText,false)


func _on_dialog_select_menu_action_selected(action: String) -> void:
	if action == "quest":
		questFromNPC()
	elif action == "talk":
		talkingWithNPC()
	else:
		closeInteraction()
		
func questFromNPC():
	gameNode.changeVisibility(actionSelectMenu,false)
	gameNode.changeVisibility(dialogPeice,true)
	if GameManager.chef_quest:
		dialogText.text = "Thank you for your help. No more quests for now."
	else:
		dialogText.text = "Please get me 5 mushrooms for my signature mushroom and chicken dish."
		
		
	gameNode.changeVisibility(okBtn,true)
	
		
func talkingWithNPC():
	gameNode.changeVisibility(actionSelectMenu,false)
	gameNode.changeVisibility(dialogPeice,true)
	if not GameManager.chef_quest:
		dialogText.text = "Complete my quest to unlock recipe."
		gameNode.changeVisibility(okBtn,true)
	else:
		dialogText.text = "Hello "+ player.playerName+", would you like to buy my signature mushroom and chicken dish for $50?(+10HP)"
		gameNode.changeVisibility(yesAndNoBTN,true)
		 
	
func closeInteraction():
	gameNode.changeVisibility(dialogComponet,false)
	dialogComponet.visible = true
	gameNode.changeVisibility(instructionText,true)


func _on_yes_pressed() -> void:
	if GameManager.player_money >= 50:
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
