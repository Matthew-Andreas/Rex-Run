extends Area2D

@onready var interact = $InstructionObject
@onready var gameNode = get_parent()
func  _ready() -> void:
	interact.visible = false
	
	


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if gameNode.boatOwned:
			interact.visible = true
			GameManager.leaveOnBoat = true
		


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		if gameNode.boatOwned:
			interact.visible = false
			GameManager.leaveOnBoat = false
