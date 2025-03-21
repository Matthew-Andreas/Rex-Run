extends Node2D

var state = false
var boatOwned = false

@onready var boatSeller = $"Boat Seller"
@onready var player = $Player
@onready var chef = $ChefArea/Chef
@onready var shopKeeper = $"Shop Keeper"
#@onready var boatSellerBtns = $"Boat Seller/Dialog/DialogButtons"

signal talkingWithBoatGuy()
signal talkingWithChef()
signal talkingWithShopKeeper()

func _ready() -> void:
	changeVisibility($"Boat Seller/DialogBlock",false)
	changeVisibility($ChefArea/Chef/DialogBlock, false)
	changeVisibility($"Shop Keeper/DialogBlock",false)
	player.hub = true

func _on_player_interactwith_npc(name: String) -> void:
	if name == boatSeller.name:
		talkingWithBoatGuy.emit()
	elif name == chef.name:
		talkingWithChef.emit()
	elif name == shopKeeper.name:
		talkingWithShopKeeper.emit()
		
		


func changeVisibility(targetNode: Node, visibility: bool):
	targetNode.propagate_call("set_visible",[visibility])



	
