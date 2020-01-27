extends KinematicBody2D

var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO

func get_input():
    velocity = Vector2.ZERO
    
    if Input.is_action_pressed('ui_down'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 1
    # Make sure diagonal movement isn't faster
    velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		SignalManager.emit_signal("CloseAsteroids")
