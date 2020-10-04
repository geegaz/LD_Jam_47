extends Control

onready var _MainMenu = $MainMenu
onready var _GameSelect = $GameSelect
onready var _Back = $Back

var state = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_state(0)

func _input(event):
	if event.is_action_pressed("ui_menu"):
		match state:
			0:
				get_tree().quit()
			_:
				set_state(0)

func _on_Back_pressed():
	set_state(0)

func _on_SelectGame_pressed():
	set_state(1)

func _on_Options_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()

func _on_CircularPong_pressed():
	get_tree().change_scene("res://Scenes/Games/CirclePong.tscn")

func _on_SpaceInfiltration_pressed():
	get_tree().change_scene("res://Scenes/Games/SpaceRacer.tscn")

func _on_BreezeMaker_pressed():
	get_tree().change_scene("res://Scenes/Games/BreezeWaker.tscn")

func set_state(new_state):
	state = new_state
	match new_state:
		0:
			_GameSelect.hide()
			_MainMenu.show()
			_Back.hide()
		1:
			
			_GameSelect.show()
			_MainMenu.hide()
			_Back.show()

func reveal_games():
	pass
