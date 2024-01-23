extends Node2D

var overworld_scene
var combat_scene
@export var rumorAmount : int
@export var maxRumor : int = 100
@export var rumorBar : ProgressBar

func _ready():
	overworld_scene = get_node("Overworld")
	combat_scene = get_node("Encounter") as EncounterManager
	combat_scene.visible = false
	rumorAmount = maxRumor / 2;
	rumorBar.set_value(rumorAmount)

func start_combat(enemy : Enemy):
	overworld_scene.process_mode = PROCESS_MODE_DISABLED
	combat_scene.visible = true
	combat_scene.start_encounter(enemy)
	
func end_combat():
	combat_scene.visible = false
	overworld_scene.process_mode = PROCESS_MODE_INHERIT
	print("ending combat")
	
func get_hurt(amount : int):
	rumorAmount += amount
	rumorBar.set_value(rumorAmount)
	if rumorAmount > maxRumor : print("Too much has spread")
