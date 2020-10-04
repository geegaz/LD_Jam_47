extends Node2D

signal apply_wind(force)

onready var _GameUI = $UILayer/GameUI
onready var _Fan = $UILayer/Center/Fan
onready var BonusPos = $BonusSpawns.get_children() 

var Bonus = preload("res://Scenes/Games/Bonus2DDrawn.tscn")
var last_pos_id = 0

var prev_angle
var rot_speed = 0.0
var prev_rot_speed = 0.0
var saved_angle

var change_time = 0.0

var speed = 2.5
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	Global._Circle.connect("angle_changed", self, "_on_Circle_angle_changed")
	$UILayer/Center.position = Global._Circle.position
	generate_bonus()

func _physics_process(delta):
	
	if sign(prev_rot_speed) != sign(rot_speed):
		prev_rot_speed = rot_speed
		var prev_saved_angle = saved_angle
		saved_angle = prev_angle
		if change_time < 0.3 and abs(rad2deg(saved_angle-prev_angle)) < 15:
			emit_signal("apply_wind", speed)
		change_time = 0.0
		
	elif change_time < 1.0:
		change_time += delta

func _on_Circle_angle_changed(angle):
	if prev_angle:
		rot_speed = angle - prev_angle
	prev_angle = angle
	if !saved_angle:
		saved_angle = angle

func _on_Bonus_body_entered(body):
	if body.is_in_group("Player"):
		_GameUI.add_score(10)
		generate_bonus()

func generate_bonus():
	var max_pos_id = BonusPos.size()
	var pos_id = randi()%max_pos_id
	while pos_id == last_pos_id:
		pos_id = randi()%max_pos_id
	var _Bonus = Bonus.instance()
	_Bonus.connect("body_entered", self,"_on_Bonus_body_entered")
	_Bonus.position = BonusPos[pos_id].position
	self.add_child(_Bonus)

func _on_PlayerBoat_hit_rock():
	$Sounds/Break.play()
	_GameUI.call_deferred("game_over")
