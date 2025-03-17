extends Node2D

var state = false
var boatOwned = false

@onready var boatSeller = $"Boat Seller"
@onready var player = $Player
#@onready var boatSellerBtns = $"Boat Seller/Dialog/DialogButtons"

signal talkingWithBoatGuy()

func _ready() -> void:
	changeVisibility($"Boat Seller/DialogBlock",false)
	player.hub = true

func _on_player_interactwith_npc(npm_name: String) -> void:
	if npm_name == boatSeller.name:
		talkingWithBoatGuy.emit()


func changeVisibility(targetNode: Node, visibility: bool):
	targetNode.propagate_call("set_visible",[visibility])



	
