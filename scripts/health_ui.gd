extends CanvasLayer

@onready var label = $Label

func update_health_label(player_health):
	label.text = "Health: " + str(player_health)
