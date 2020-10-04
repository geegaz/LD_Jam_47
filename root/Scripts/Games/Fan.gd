extends Node2D

export var fan_distance = 200

var angle = 0.0
var target_angle = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	Global._Circle.connect("angle_changed", self, "_on_Circle_angle_changed")

func _physics_process(delta):
	angle = lerp_angle(angle, target_angle, 0.1)
	position = Vector2(cos(angle), sin(angle))*fan_distance
	rotation = angle+PI
	$FanSprite.rotation = (target_angle+PI-angle+PI)*2

func _on_Circle_angle_changed(angle):
	target_angle = angle


func _on_BreezeWaker_apply_wind(force):
	$WindParticles.emitting = true
	$Timer.start()


func _on_Timer_timeout():
	$WindParticles.emitting = false
