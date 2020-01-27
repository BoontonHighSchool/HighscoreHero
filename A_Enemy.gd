extends RigidBody2D

export var min_speed = 350  # Minimum speed range.
export var max_speed = 550  # Maximum speed range.
var mob_types = ["E1", "E2", "E3"]

func _ready():
	$Sprite.animation = mob_types[randi() % mob_types.size()]
	SignalManager.connect("CloseAsteroids", self, "CloseAsteroids")

func CloseAsteroids():
	queue_free()


func _on_Enemy_body_entered(body):
	if body.has_method("kill"):
		body.kill()


func _on_Enemy_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.has_method("kill"):
		body.kill()

func kill():
	queue_free()