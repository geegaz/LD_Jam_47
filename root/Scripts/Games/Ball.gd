extends KinematicBody2D

signal hit_paddle

var speed: float = 100 # px/s
var velocity: Vector2

func _ready():
	self.connect("hit_paddle", get_parent(), "_on_Ball_hit_paddle")
	velocity = Vector2.UP.rotated(rotation)*speed

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		rotation = velocity.angle()

func destroy():
	$Sprite.hide()
	$AnimatedSprite.play()
	self.velocity = Vector2.ZERO
