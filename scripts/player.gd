extends CharacterBody2D

signal interactwithNPC(name:String)

const SPEED = 120.0
const BIG_SPEED = 460.0
const JUMP_VELOCITY = -300.0
const BIG_JUMP_VELOCITY = -700.0
const DAMAGE_TIME = 60

@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var canvas_layer = $CanvasLayer

@export var playerName = "Tom"
@export var money = 20
var nextToBoatGuy = false
var mainLand = false
var prev_health : float
var play_damage : bool

func _ready() -> void:
	prev_health = health_component.health
	canvas_layer.update_health_label(prev_health)

func _physics_process(delta: float) -> void:
	# add the gravity
	if not is_on_floor() and not mainLand:
		velocity += get_gravity() * delta
	elif not is_on_floor() and mainLand:
		velocity += get_gravity() * delta * 1.5

	# handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and not mainLand:
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("jump") and is_on_floor() and mainLand:
		velocity.y = BIG_JUMP_VELOCITY

	# get's input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
		# flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# play animation
	if is_on_floor() and not play_damage:
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	elif not play_damage:
		animated_sprite.play("jump")
		
	if prev_health > health_component.health:
		play_damage = true
		animated_sprite.play("damage")
		prev_health = health_component.health
		canvas_layer.update_health_label(prev_health)
		timer.start()
	
	# apply movement
	if not mainLand:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		if direction:
			velocity.x = direction * BIG_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, BIG_SPEED)
	

	move_and_slide()
	
	if nextToBoatGuy and Input.is_action_just_pressed("interact"):
		interactwithNPC.emit("Boat Seller")
		
	if Input.is_action_just_pressed("temp_Scene_Switch"):
		if not mainLand:
			get_tree().change_scene_to_file("res://scenes/mainLand.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_timer_timeout() -> void:
	play_damage = false
