extends Area2D
@export var speed_boost_amount: float = 100.0  # Adjust speed boost
@export var boost_duration: float = 10.0  # Power-up lasts for 10 seconds

# Called when the player enters the power-up area
func _on_body_entered(body):
	if body.is_in_group("player"):  
		body.apply_speed_boost(speed_boost_amount, boost_duration)
		queue_free()  # Removes the power-up after pickup
