extends CharacterBody2D

@export var SPEED = 300
@export var GRAVITY = 30
@export var JUMP = 600
@onready var shooting = $AudioStreamPlayer
@onready var bullet = preload("res://scenes/bullet.tscn")
const MAXHP = 3
var health = MAXHP

var heartList = []

func _ready() -> void:
	var heartsParents = $hpbar/HBoxContainer
	
	for child in heartsParents.get_children():
		heartList.append(child)

func updateHeartDisplay():
	for i in range(heartList.size()):
		heartList[i].visible = i < health

func take_damage():
	if (health > 0):
		health -= 1
		updateHeartDisplay()

	if (health == 0):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")




func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY
		if velocity.y > 600:
			velocity.y = 600

	if Input.is_action_just_pressed("jump"):
		if (is_on_floor()):
			velocity.y = -JUMP

	shoot()

	var x_dir = Input.get_axis("move_left", "move_right");

	velocity.x = 300 * x_dir
		
	if (x_dir == -1): 	
		$AnimatedSprite2D.flip_h

	move_and_slide() 

func shoot():
	if Input.is_action_just_pressed("shoot_right"):
		var temp = bullet.instantiate()
		get_tree().current_scene.add_child(temp)
		temp.global_position = $bullet.global_position
		temp.direction = 1
		temp.scale.x = 1
		shooting.play()

	elif Input.is_action_just_pressed("shoot_left"):
		var temp = bullet.instantiate()
		get_tree().current_scene.add_child(temp)
		temp.global_position = $bullet.global_position
		temp.direction = -1
		temp.scale.x = -1
		shooting.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		take_damage()
