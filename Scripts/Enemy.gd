extends Sprite2D

class_name Enemy

@export var interact_range : float = 30.0
@export var health : int = 3
var interact_ui
var player
var game_manager
enum EnemyType {TYPE_1, TYPE_2, TYPE_3}
var currentType : EnemyType
var final_boss : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	interact_ui = get_node("Panel")
	interact_ui.visible = false
	player = get_node("/root/Main/Overworld/Player")
	game_manager = get_node("/root/Main")
	currentType = EnemyType.TYPE_1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	##print(position.distance_to(player.position))
	if (interact_ui.visible == false) and (position.distance_to(player.position) <= interact_range):
		interact_ui.visible = true
	elif (interact_ui.visible == true) and (position.distance_to(player.position) > interact_range):
		interact_ui.visible = false


func _on_combat_button_pressed():
	game_manager.start_combat(self)

func _on_accuse_button_pressed():
	player.set_process(true)
