extends Node2D

onready var _Sprite = $Sprite
var cursor_textures = [
	preload("res://Assets/Sprites/Cursor_arrow.svg"),
	preload("res://Assets/Sprites/Cursor_square.svg"),
	preload("res://Assets/Sprites/Cursor_circle.svg")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_cursor(id: int):
	# 0 = arrow
	# 1 = square
	# 2 = circle
	match id:
		0:
			_Sprite.texture = cursor_textures[0]
			_Sprite.offset = Vector2(0, -70)
			_Sprite.rotation_degrees = 90
		1:
			_Sprite.texture = cursor_textures[1]
			_Sprite.offset = Vector2.ZERO
			_Sprite.rotation_degrees = 0
		2:
			_Sprite.texture = cursor_textures[2]
			_Sprite.offset = Vector2.ZERO
			_Sprite.rotation_degrees = 0
