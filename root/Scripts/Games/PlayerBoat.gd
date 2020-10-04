extends KinematicBody2D

signal hit_rock

var velocity = Vector2.ZERO
var damaged = false
var time = 0.0

func _ready():
	$Boat.material.set_shader_param("blink", false)

func _physics_process(delta):
	$Boat.flip_h = (velocity.x > 0.0)
	
	var speed = velocity.length()*delta/2
	$Boat.material.set_shader_param("speed", speed)
	
	velocity = velocity.linear_interpolate(Vector2.ZERO, 0.01)
	var collision = move_and_collide(velocity*delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		damaged = true
		$Boat.material.set_shader_param("blink", true)
		emit_signal("hit_rock")

func _process(delta):
	if damaged and time < 2.0:
		_damaged_process(delta)
	

func _damaged_process(delta):
	time += delta
	if time >= 2.0:
		$Boat.material.set_shader_param("blink", false)
		$Boat.rotation = 0.0
	else:
		$Boat.rotation = sin(time*2*PI)*0.5

func _on_BreezeWaker_apply_wind(force):
	var dir = Vector2.UP.rotated(Global._Circle.angle-PI/2)
	velocity += dir*clamp(force, 0.0, 10.0)*8.0
