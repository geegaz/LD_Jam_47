extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _Paddle = $Center/Paddle
onready var _GameUI = $GameUI

export var paddle_distance = 150

var playing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Global._Circle.connect("angle_changed", self, "_on_Circle_angle_changed")
	$Center.position = Global._Circle.position

func _on_Circle_angle_changed(angle): # angle in rad
	_Paddle.rotation = angle
	_Paddle.position = Vector2(cos(angle), sin(angle))*paddle_distance

func _on_Ball_hit_paddle():
	Global.score

func _on_Area2D_body_exited(body):
	if body == $Ball and playing:
		$Ball.destroy()
		playing = false
	
		yield(get_tree().create_timer(0.5), "timeout")
		
		_GameUI.game_over()
	
