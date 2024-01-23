extends Sprite2D

var move_target : Vector2
@export var bg : Control
@export var move_speed : float
@export var collider : CollisionShape2D
signal player_hurt
signal player_hit_goal

# Called when the node enters the scene tree for the first time.
func _ready():
	move_target = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_distance = position.distance_to(move_target)
	
	if move_distance <= 10 && move_distance != 0:
		position = move_target
	elif move_distance > 10:
		position += position.direction_to(move_target) * move_speed
		


func _on_minigame_bg_gui_input(event):
	if Input.is_action_pressed("left_click"):
		move_target = get_viewport().get_mouse_position() - bg.position
		var size := Vector2(self.texture.get_width(), self.texture.get_height())
		
		##Width clamping, don't judge me for my hacky math
		if move_target.x > (bg.size.x - size.x/4) : move_target.x = (bg.size.x - size.x/4)
		elif move_target.x < (size.x/4) : move_target.x = (size.x/4)
		##Height clamping
		if move_target.y > (bg.size.y - size.y/4) : move_target.y = (bg.size.y - size.y/4)
		elif move_target.y < (size.y/4) : move_target.y = (size.y/4)

func _on_player_area_area_entered(area):
	if (area.name == "ObstacleArea") : player_hurt.emit()
	elif (area.name == "GoalArea") : player_hit_goal.emit()


func _on_minigame_bg_visibility_changed():
	move_target = position
