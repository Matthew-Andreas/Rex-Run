extends Area2D

# Remove coin when a body has entered
func _on_body_entered(_body: Node2D) -> void:
	queue_free()
