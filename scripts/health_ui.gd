extends CanvasLayer

@onready var health = $Health
@onready var money = $Money

func _ready() -> void:
	update_money_label(GameManager.player_money)

func update_health_label(player_health):
	health.text = "Health: " + str(player_health)
	
func update_money_label(player_money):
	money.text = "Coins: " + str(player_money)
