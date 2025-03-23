extends Area2D
@onready var ui =  %Player/HealthCanvas
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Remove coin when a body has entered
func _on_body_entered(body: Node2D) -> void:
	if body.money_component:
		body.money_component.earn()
		ui.update_money_label(GameManager.player_money)
	animation_player.play("pick_up")
