extends Node2D

signal actionSelected(action: String)

func _on_quest_pressed() -> void:
	actionSelected.emit("quest")


func _on_talk_pressed() -> void:
	actionSelected.emit("talk")


func _on_cancel_pressed() -> void:
	actionSelected.emit("cancel")
