extends Area2D

# Remove mushroom when a body has entered
func _on_body_entered(_body: Node2D) -> void:
	queue_free()
