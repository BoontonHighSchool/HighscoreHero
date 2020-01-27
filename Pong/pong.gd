
extends Node2D

# Member variables
const INITIAL_BALL_SPEED = 100
var ball_speed = INITIAL_BALL_SPEED
var screen_size = Vector2(512, 300)
# Default ball direction
var direction = Vector2(-1, 0)
var pad_size = Vector2(8, 32)
var Rpad_size = Vector2(8, 350)
const PAD_SPEED = 150

var localScore = 0

func _process(delta):
	$localScore.set_text(str(localScore))
	# Get ball position and pad rectangles
	var ball_pos = get_node("ball").get_position()
	var left_rect = Rect2(get_node("left").get_position() - pad_size * 0.5, pad_size)
	var right_rect = Rect2(get_node("right").get_position() - Rpad_size * 0.5, Rpad_size)
	
	# Integrate new ball postion
	if Global.PlayPong == true:
		ball_pos += direction * ball_speed * delta
	
	# Flip when touching roof or floor
	if (ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0):
		direction.y = -direction.y
	
	# Flip, change direction and increase speed when touching pads
	if (left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0):
		localScore += 1
		direction.x = -direction.x
		ball_speed *= 1.1
		direction.y = randf() * 2.0 - 1
		direction = direction.normalized()
	
	# Check gameover
	if ball_pos.x < 0:
		Global.PlayPong = false
		SignalManager.emit_signal("ClosePong")
		if localScore > Global.P_High:
			Global.P_High = localScore

		ball_pos = screen_size * 0.5
		ball_speed = 0
		direction = Vector2(-1, 0)
	
	get_node("ball").set_position(ball_pos)
	
	# Move left pad
	var left_pos = get_node("left").get_position()
	
	if left_pos.y > 0 and Input.is_action_pressed("ui_up"):
		left_pos.y += -PAD_SPEED * delta
	if left_pos.y < screen_size.y and Input.is_action_pressed("ui_down"):
		left_pos.y += PAD_SPEED * delta
	
	get_node("left").set_position(left_pos)
	
func _ready():
#	screen_size = $BKG.size # Get actual size
	pad_size = get_node("left").get_texture().get_size()
	SignalManager.connect("OpenPong", self, "OpenPong")
	set_process(true)

func OpenPong():
	var leftStart = $left.get_position_in_parent()
	var ball_pos = get_node("ball").get_position()
	localScore = 0
	leftStart = screen_size * 0.5
	ball_pos = screen_size * 0.5
	ball_speed = INITIAL_BALL_SPEED
	direction = Vector2(-1, 0)
	Global.PlayPong = true