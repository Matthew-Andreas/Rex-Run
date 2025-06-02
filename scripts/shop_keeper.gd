class_name basic_NPC

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
@onready var HealthCanvas = $"../Player/HealthCanvas"
var player

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		body.nextToShopKeeper = true
		dialogComponet.visible = true
		gameNode.changeVisibility(instructionText,true)
		
func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.nextToShopKeeper = false
		gameNode.changeVisibility(dialogComponet,false)
		GameManager.interactingWithNPC = false
		


func _on_game_talking_with_shop_keeper() -> void:
	if not GameManager.interactingWithNPC: 
		GameManager.interactingWithNPC = true
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
	if GameManager.shop_keeper_quest:
		dialogText.text = "Thank you for your help. No more quests for now."
	else:
		dialogText.text = "Please get me 4 ballons for my sons birthday party."
		
		
	gameNode.changeVisibility(okBtn,true)
	
		
func talkingWithNPC():
	gameNode.changeVisibility(actionSelectMenu,false)
	gameNode.changeVisibility(dialogPeice,true)
	if not GameManager.shop_keeper_quest:
		dialogText.text = "Complete my quest to unlock items."
		gameNode.changeVisibility(okBtn,true)
	elif GameManager.shop_keeper_quest and not GameManager.SK_item1_owned:
		
		dialogText.text = "Hello "+ player.playerName+", would you like to buy Tougher Skin for $100?(reduces damage taken by half)"
		gameNode.changeVisibility(yesAndNoBTN,true)
	elif GameManager.shop_keeper_quest and not GameManager.SK_item2_owned:
		dialogText.text = "Hello "+ player.playerName+", would you like to buy Coin Multiplier for $150?(double coins value)"
		gameNode.changeVisibility(yesAndNoBTN,true)
	else:
		dialogText.text = "No more items to buy."
		gameNode.changeVisibility(okBtn,true)
		 
	
func closeInteraction():
	GameManager.interactingWithNPC = false
	gameNode.changeVisibility(dialogComponet,false)
	dialogComponet.visible = true
	gameNode.changeVisibility(instructionText,true)


func _on_yes_pressed() -> void:
	if not GameManager.SK_item1_owned and GameManager.player_money >= 100:
		GameManager.player_money -= 100
		dialogText.text = "Ok, here is the Tougher Skin. Good Luck!"
		GameManager.damage_mutiplier /=2
		HealthCanvas.update_money_label(GameManager.player_money)
		GameManager.SK_item1_owned = true
	elif not GameManager.SK_item2_owned and GameManager.player_money >=150:
		GameManager.player_money -= 150
		dialogText.text = "Ok, here is the Coin Multiplier. Good Luck!"
		GameManager.coin_multiplier *= 2
		HealthCanvas.update_money_label(GameManager.player_money)
		GameManager.SK_item2_owned = true
	else:
		dialogText.text = "You do not have enough money to buy this item."
		
	gameNode.changeVisibility(yesAndNoBTN,false)
	gameNode.changeVisibility(okBtn,true)
		


func _on_no_pressed() -> void:
	closeInteraction()


func _on_ok_pressed() -> void:
	closeInteraction()
