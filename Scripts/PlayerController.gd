extends CharacterBody2D

@export var indicator : Node2D
var move_target : Vector2
var distance_to_target : float
@export var speed : float = 1.0

func _ready():
	move_target = position

func _process(delta):
	##Setting target
	if Input.is_action_pressed("left_click"):
		##print("mouse clicked")
		move_target = get_global_mouse_position()
		##indicator.position = move_target
	
	##Moving to target with collision
	distance_to_target = position.distance_to(move_target)
	if distance_to_target > speed:
		velocity = (move_target - position).normalized() * speed
		if move_and_collide(velocity):
			move_target = position
			pass
	elif speed > distance_to_target and distance_to_target > 0.0:
		velocity = move_target - position
		if move_and_collide(velocity):
			move_target = position
			pass
	else:
		velocity = Vector2.ZERO
