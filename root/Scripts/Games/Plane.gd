extends KinematicBody

signal hit_ship
signal passed_ship

var Block = preload("res://Scenes/Games/Block.tscn")
# Called when the node enters the scene tree for the first time.
var difficulty = 50.0 # difficulty from 0 to 100
var speed = 10.0

var Shapes = []

func _ready():
	randomize()
	var hole = randi()%8
	for i in range(8):
		if randf()*100-20 < difficulty and i != hole:
			generate(i)

func _physics_process(delta):
	var collision = move_and_collide(Vector3.BACK*speed*delta)
	if collision:
		for shape in Shapes:
			shape.set_deferred("disabled", true)
		emit_signal("hit_ship")
	
	if translation.z >= 4:
		emit_signal("passed_ship")
		queue_free()

func generate(i): 
	var angle = (-PI*2)/8 * i
	var _Block = Block.instance()
	_Block.translation = Vector3(cos(angle), sin(angle), 0.0) * 1.2
	_Block.rotation.z = angle+(PI/2)
	Shapes.append(_Block)
	self.add_child(_Block)
