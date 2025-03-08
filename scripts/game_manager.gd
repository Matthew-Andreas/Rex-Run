extends Node

var current_scene = null

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

func restart_on_death():
	get_tree().call_deferred("reload_current_scene")
