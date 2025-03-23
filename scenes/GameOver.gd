extends Control
# Called when the node enters the scene
func _ready():
	# Connect buttons to functions
	print("Game Over screen loaded")
	#$RetryButton.pressed.connect(_on_retry_pressed)
	#$MainMenuButton.pressed.connect(_on_main_menu_pressed)
	$VBoxContainer/RetryButton.pressed.connect(_on_retry_pressed)
	$VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu_pressed)

# Function to restart the level
func _on_retry_pressed():
	get_tree().reload_current_scene()  # Reloads the current level

# Function to go to the main menu
func _on_main_menu_pressed():
	#get_tree().change_scene_to_file("res://scenes/GameOver.tscn")  
	print("Main Menu button pressed")
