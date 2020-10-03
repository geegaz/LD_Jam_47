extends Node2D

onready var _Ship = $Viewport/Spatial/ShipBody
onready var _WallSpawn = $Viewport/Spatial/WallSpawn
onready var _GameUI = $GameUI
var Wall = preload("res://Scenes/Games/Wall.tscn")
var Bonus = preload("res://Scenes/Games/Bonus3D.tscn")

export var ship_distance = 1.5
var local_difficulty = 1.0 # 1.0 to 100.0

var smoothness = 0.1
var target_angle = 0.0
var angle = 0.0
var bonus_countdown = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	Global._Circle.connect("angle_changed", self, "_on_Circle_angle_changed")


func _physics_process(delta):
	angle = lerp_angle(angle, target_angle, smoothness)
	_Ship.translation = Vector3(cos(target_angle), -sin(target_angle), 0.0)*ship_distance
	_Ship.rotation.z = -angle + (PI/2)

func _on_Circle_angle_changed(angle):
	target_angle = angle

func _on_Wall_hit_ship():
	_GameUI.call_deferred("game_over")

func _on_Wall_passed_ship():
	Global.add_score(1)
	local_difficulty += 0.5

func _on_WallTimer_timeout():
	var _Wall = Wall.instance()
	_Wall.connect("hit_ship", self, "_on_Wall_hit_ship")
	_Wall.connect("passed_ship", self, "_on_Wall_passed_ship")
	_Wall.translation.z = _WallSpawn.translation.z
	_Wall.difficulty = local_difficulty
	_Wall.speed = 5+(local_difficulty/4)
	$Viewport/Spatial/WallTimer.wait_time = 1.0-(0.006*local_difficulty)
	$Viewport/Spatial.add_child(_Wall)
	
	if bonus_countdown == 0:
		_Wall.add_child(create_bonus()) # returns a bonus node and adds it to the wall
	else:
		bonus_countdown -= 1

func _on_Bonus_body_entered(body, emitter):
	Global.add_score(10)
	emitter.queue_free()

func create_bonus():
	bonus_countdown = 10
	var _Bonus = Bonus.instance()
	var angle_local = randi()%8*((PI*2)/8)
	_Bonus.translation = Vector3(cos(angle_local), sin(angle_local), -3.0+(local_difficulty/4))*1.5
	_Bonus.connect("body_entered", self, "_on_Bonus_body_entered", [_Bonus])
	return(_Bonus)
