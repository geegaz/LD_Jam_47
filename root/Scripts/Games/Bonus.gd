extends Node

export var Visual: NodePath
export var Collision: NodePath
export var Particle: NodePath

onready var _Visual: Node = get_node(Visual)
onready var _Collision: Node = get_node(Collision)
onready var _Particle: Node = get_node(Particle)

var waiting_delete = false

func _process(delta):
	if waiting_delete and !_Particle.emitting:
		queue_free()
			
func _on_Bonus2D_body_entered(body):
	if body.is_in_group("Player"):
		$BonusSound.play()
		_Collision.set_deferred("disabled", true)
		_Visual.hide()
		_Particle.emitting = true
		waiting_delete = true
