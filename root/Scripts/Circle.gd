extends Node2D

export var circle_width = 100

onready var _Circle = $CircleLine
onready var _Cursor = $Cursor

var controller_connected: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	check_joypads_status()
	
	var vec: Vector2 = Vector2(0, circle_width)
	for i in range(361):
		_Circle.add_point(vec.rotated(deg2rad(i)))

func _physics_process(delta):
	var pos
	if controller_connected:
		var pos_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		var pos_y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		pos = Vector2(pos_x, pos_y).normalized()
	else:
		pos = get_local_mouse_position().normalized()
	
	if pos != Vector2.ZERO:
		_Cursor.position = pos*circle_width
		_Cursor.rotation = pos.angle()

func _on_joy_connection_changed(device_id, connected):
	check_joypads_status()

func check_joypads_status():
	var ids = Input.get_connected_joypads()
	controller_connected = ids.size() > 0
