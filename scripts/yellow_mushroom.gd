extends Area2D

# Remove mushroom when a body has entered
func _on_body_entered(_body: Node2D) -> void:
	GameManager.quest_item_collected("Mushroom")
	queue_free()
