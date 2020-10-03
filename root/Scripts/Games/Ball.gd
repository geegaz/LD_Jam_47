extends KinematicBody2D

signal hit_paddle

var speed: float = 200 # px/s
var acceleration: float = 1.01
var velocity: Vector2

func _ready():
	self.connect("hit_paddle", get_parent(), "_on_Ball_hit_paddle")
	velocity = Vector2.UP*speed

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		velocity = velocity.bounce(collision.normal)*acceleration
		emit_signal("hit_paddle")
	
func destroy():
	$Sprite.hide()
	$AnimatedSprite.play()
	$CollisionShape2D.set_deferred("disabled",true)
	self.velocity = velocity/10
