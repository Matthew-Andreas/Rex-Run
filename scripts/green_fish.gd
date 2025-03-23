extends Area2D


func _on_body_entered(body: Node2D) -> void:
	GameManager.quest_item_collected("fish")
	queue_free()
