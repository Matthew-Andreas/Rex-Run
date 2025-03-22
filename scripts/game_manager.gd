extends Node

var boat_guy_quest = false
var chef_quest = true
var shop_keeper_quest = true
var SK_item1_owned = false
var SK_item2_owned = false
var current_scene = null
var player_money = 300
var level_earned_money = 0
var player_current_Health_cap := 10.0
var damage_mutiplier := 2
var coin_multiplier := 1

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

func restart_on_death():
	get_tree().call_deferred("reload_current_scene")
	player_money -= level_earned_money 
	level_earned_money = 0

func load_level(level_path):
	get_tree().call_deferred("change_scene_to_file", level_path)
	level_earned_money = 0
