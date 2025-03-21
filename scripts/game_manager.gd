extends Node

var boat_guy_quest = false
var chef_quest = false
var current_scene = null
var player_money = 20

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

func restart_on_death():
	get_tree().call_deferred("reload_current_scene")
