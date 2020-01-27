extends KinematicBody2D

var InFront = false

const MOTION_SPEED = 160 # Pixels/second

func _ready():
	InFront = false
	SignalManager.connect("Alert", self, "Alert")
	
func Alert():
	$AnimationPlayer.play("Alert")
	

#func _input(event):
#    if event is InputEventKey:
#        if !event.pressed:
#            $AnimatedSprite.stop()

func _physics_process(_delta):
	var motion = Vector2()
	
	
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1, 0)
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = false
	if Input.is_action_just_released("ui_left"):
		$AnimatedSprite.stop()
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1, 0)
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = true
	if Input.is_action_just_released("ui_right"):
		$AnimatedSprite.stop()
	if Input.is_action_pressed("ui_accept") and InFront == true:
		$AnimatedSprite.play("Play")

			
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)

func _on_Area2D_area_entered(area):
	if area.is_in_group("arcade"):
		InFront = true

func _on_Area2D_area_exited(area):
	if area.is_in_group("arcade"):
		InFront = false