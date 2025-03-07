extends Area2D

# Timer for game restart when player dies
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("Player died.")
	# set time scale to 0.5 for slowmotion effect
	Engine.time_scale = 0.5
	# remove player collison object for falling off map effect
	body.get_node("CollisionShape2D").queue_free()
	# Start timer for game restart
	timer.start()

func _on_timer_timeout() -> void:
	# reset time scale back to 1
	Engine.time_scale = 1
	# when timer ends reload the current scene
	get_tree().reload_current_scene()
