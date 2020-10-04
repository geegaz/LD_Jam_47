extends Node2D

signal angle_changed(angle) # angle in rad

export var circle_width = 100

onready var _Circle = $CircleLine
onready var _Cursor = $Cursor

var angle

# Called when the node enters the scene tree for the first time.
func _ready():
	var vec: Vector2 = Vector2(0, circle_width)
	for i in range(361):
		_Circle.add_point(vec.rotated(deg2rad(i)))

func _input(event):
	if event is InputEventMouseMotion:
		var pos = get_local_mouse_position().normalized()
		if pos != Vector2.ZERO:
			angle = pos.angle()
			_Cursor.position = pos*circle_width
			_Cursor.rotation = angle
			emit_signal("angle_changed", angle)
