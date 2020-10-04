extends Node

onready var _Circle = $UILayer/Circle
onready var _Score = $UILayer/CenterContainer/Score
onready var _Tween = $Tween

var score = 0
var revealed_games = 0

var best_scores = [
	0,
	0,
	0
]

# Called when the node enters the scene tree for the first time.
func _ready():
	set_score(0)

func _input(event):
	if event.is_action_pressed("ui_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func get_score():
	return self.score

func set_score(value):
	self.score = value
	_Score.text = str(score)

func remove_score(value):
	set_score(self.score - value)

func add_score(value):
	set_score(self.score + value)
	
	_Tween.interpolate_property($UILayer/CenterContainer/Score.get_material(), "shader_param/time",
		0.0,0.5, 0.2)
	if !_Tween.is_active():
		_Tween.start()
