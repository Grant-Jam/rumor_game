extends CanvasLayer

class_name  EncounterManager

var game_manager
var minigame
var player_sprite : Sprite2D
var starting_pos : Vector2
var current_enemy : Enemy
var health_bar : ProgressBar
var max_enemy_health

func _ready():
	game_manager = get_node("/root/Main")
	minigame = get_node("BG/MinigameBG")
	minigame.visible = false;
	player_sprite = get_node("BG/MinigameBG/PlayerSprite") as Sprite2D
	starting_pos = player_sprite.position
	health_bar = get_node("BG/EnemyHealthBar") as ProgressBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_attack_button_pressed():
	reset_minigame()
	minigame.visible = true

func _on_end_combat_pressed():
	game_manager.get_hurt(10)
	current_enemy.health = max_enemy_health
	game_manager.end_combat()

func _on_player_sprite_player_hurt():
	minigame.visible = false
	game_manager.get_hurt(10)
	
func _on_player_sprite_player_hit_goal():
	minigame.visible = false
	current_enemy.health -= 1
	health_bar.set_value(current_enemy.health)
	if current_enemy.health <= 0 : game_manager.end_combat()
	
func reset_minigame():
	player_sprite.position = starting_pos
	
func start_encounter(curEnemy : Enemy):
	current_enemy = curEnemy
	max_enemy_health = current_enemy.health
	health_bar.max_value = current_enemy.health
	health_bar.set_value(current_enemy.health)

