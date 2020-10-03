extends Control

onready var _Pause = $PauseMenu
onready var _GameOver = $GameOverMenu

var over = false
# Called when the node enters the scene tree for the first time.
func _ready():
	_Pause.visible = get_tree().paused
	_GameOver.visible = false

func _input(event):
	if event.is_action_pressed("ui_menu"):
		if over:
			_on_BackToMenu_pressed()
		else:
			show_menu(!get_tree().paused, _Pause)

func show_menu(show: bool, menu: Node):
	get_tree().paused = show
	menu.visible = show
	var tween = $Tween
	if show:
		tween.interpolate_property(
			menu, "modulate:a",
			0.0, 1.0,
			0.2)
		if !tween.is_active():
			tween.start()

func game_over():
	over = true
	show_menu(true, _GameOver)

func _on_Continue_pressed():
	show_menu(false, _Pause)

func _on_Retry_pressed():
	show_menu(false, _GameOver)
	get_tree().reload_current_scene()

func _on_BackToMenu_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")

