extends Control

export var game_id = 0;

onready var _Pause = $PauseMenu
onready var _GameOver = $GameOverMenu
onready var _Score = $CenterContainer/HBoxContainer/LocalScore
onready var _Tween = $Tween

var over = false
var local_score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	_Pause.visible = get_tree().paused
	_GameOver.visible = false
	_Score.text = str(local_score)

func _input(event):
	if event.is_action_pressed("ui_menu"):
		if over:
			_on_BackToMenu_pressed()
		else:
			show_menu(!get_tree().paused, _Pause)

func show_menu(show: bool, menu: Node):
	get_tree().paused = show
	menu.visible = show

	if show:
		_Tween.interpolate_property(
			menu, "modulate:a",
			0.0, 1.0,
			0.2)
		if !_Tween.is_active():
			_Tween.start()

func game_over():
	over = true
	show_menu(true, _GameOver)
	var previous_best = Global.best_scores[game_id]
	if local_score > previous_best:
		Global.remove_score(previous_best)
		Global.add_score(local_score)
		Global.best_scores[game_id] = local_score
		
		$CenterContainer/HBoxContainer/NewRecord.show()

func _on_Continue_pressed():
	show_menu(false, _Pause)

func _on_Retry_pressed():
	show_menu(false, _GameOver)
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _on_BackToMenu_pressed():
# warning-ignore:return_value_discarded
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Main.tscn")

func add_score(value):
	local_score += value
	_Score.text = str(local_score)
	
	_Tween.interpolate_property(_Score.get_material(), "shader_param/time",
		0.0,0.5, 0.2)
	if !_Tween.is_active():
		_Tween.start()

