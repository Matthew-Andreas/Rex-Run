extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func _on_body_entered(body: Node2D) -> void:
	if body.health_component:
		body.health_component.damage()
		
