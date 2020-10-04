extends KinematicBody2D

signal hit_paddle

var speed: float = 200 # px/s
var acceleration: float = 1.015
var velocity: Vector2

func _ready():
	self.connect("hit_paddle", get_parent(), "_on_Ball_hit_paddle")
	velocity = Vector2.UP.rotated(Global._Circle.angle + PI/2)*speed

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		velocity = velocity.bounce(collision.normal)*acceleration
		position += velocity*delta
		rotation = velocity.angle()
		emit_signal("hit_paddle")
	
func destroy():
	self.velocity = Vector2.ZERO
	$Sprite.hide()
	$CollisionShape2D.set_deferred("disabled",true)
	$Particles2D.emitting = true
