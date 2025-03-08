extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10.0
var health : float

func _ready() -> void:
	health = MAX_HEALTH

func damage():
	health -= 1
	print("Player took damage. Health: " + str(health))
	
	if health <= 0:
		print("Player died. Health: " + str(health))
		GameManager.restart_on_death()

func insta_kill():
	health = 0
	print("Insta Kill. Health: " + str(health))
	GameManager.restart_on_death()
