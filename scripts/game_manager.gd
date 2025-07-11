extends Node

var boat_guy_quest = false
var chef_quest = false
var shop_keeper_quest = false
var SK_item1_owned = false
var SK_item2_owned = false
var leaveOnBoat = false
var interactingWithNPC = false
var current_scene = null
var mushrooms_collected = 0
var current_level_mushrooms_collected = 0
var ballons_collected = 0
var current_level_ballons_collected = 0
var fish_collected = 0
var current_level_fish_collected = 0
var player_money = 0
var level_earned_money = 0
var player_current_Health_cap := 100.0
var damage_mutiplier := 2
var coin_multiplier := 1

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

func restart_on_death():
	get_tree().call_deferred("reload_current_scene")
	player_money -= level_earned_money 
	mushrooms_collected -= current_level_mushrooms_collected
	ballons_collected -= current_level_ballons_collected
	fish_collected -= current_level_fish_collected
	
	if(current_level_mushrooms_collected > 0):
		chef_quest = false
	if(current_level_ballons_collected > 0):
		shop_keeper_quest = false
		
	if(current_level_fish_collected>0):
		boat_guy_quest = false
	
	current_level_mushrooms_collected = 0
	current_level_ballons_collected = 0
	current_level_fish_collected = 0
	level_earned_money = 0

func load_level(level_path):
	get_tree().call_deferred("change_scene_to_file", level_path)
	level_earned_money = 0
	
func quest_item_collected(item):
	if("Mushroom" == item):
		mushrooms_collected += 1
		current_level_mushrooms_collected += 1
		if(mushrooms_collected == 5):
			chef_quest = true
	elif("balloon" == item):
		ballons_collected += 1
		current_level_ballons_collected += 1
		if(ballons_collected == 4):
			shop_keeper_quest = true
	elif("fish" == item):
		fish_collected +=1
		current_level_fish_collected +=1
		if(fish_collected == 3):
			boat_guy_quest =true		
	
