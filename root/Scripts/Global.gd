extends Node

onready var _Circle = $UILayer/Circle
onready var _Score = $UILayer/CenterContainer/Score

var score = 0
var revealed_games = 0
var angle = 0.0

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

func add_score(value):
	set_score(self.score + value)
