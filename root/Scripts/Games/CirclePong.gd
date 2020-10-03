extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _Paddle = $Center/Paddle
onready var _GameUI = $GameUI

var Bonus = preload("res://Scenes/Games/Bonus2D.tscn")
export var paddle_distance = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	Global._Circle.connect("angle_changed", self, "_on_Circle_angle_changed")
	$Center.position = Global._Circle.position
	$Ball.position = $Center.position
	generate_bonus()

func _on_Circle_angle_changed(angle): # angle in rad
	_Paddle.rotation = angle
	_Paddle.position = Vector2(cos(angle), sin(angle))*paddle_distance

func _on_Ball_hit_paddle():
	Global.add_score(1)

func _on_Area2D_body_exited(body):
	if body == $Ball:
		$Ball.destroy()
		_GameUI.call_deferred("game_over")

func _on_Bonus_body_entered(body, emitter):
	Global.add_score(10)
	emitter.queue_free()
	call_deferred("generate_bonus")
		
func generate_bonus():
	var distance = randf()*150
	var angle = randf()* PI*2
	var _Bonus = Bonus.instance()
	$Center.add_child(_Bonus)
	_Bonus.position = (Vector2.UP*distance).rotated(angle)
	_Bonus.connect("body_entered", self,"_on_Bonus_body_entered", [_Bonus])
	
