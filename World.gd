extends Node2D

var atAsteroids = false
var atPong = false
var anim_types = ["Enemy-Walk","Enemy-Asteroids","Enemy-Pong","Enemy-A-Short","Enemy-P-Short"]

var A_High = 0
var P_High = 0
export var A_Set = false
export var P_Set = false
var PlayPong = false
var PlayAsteroids = false

var StartPong = false
var StartAsteroids = false


func _ready():
	randomize()
	A_Set = false
	P_Set = false
#	$WaitTimer.start()

func _process(delta):
	if atAsteroids == true && Input.is_action_just_released("ui_select"):
		SignalManager.emit_signal("OpenAsteroids")
	if atPong == true && Input.is_action_just_released("ui_select"):
		SignalManager.emit_signal("OpenPong")


	if P_Set == true:
		Global.P_High += 1
		SignalManager.emit_signal("Alert")


	if A_Set == true:
		Global.A_High += 1
		SignalManager.emit_signal("Alert")

func _on_AsteroidsArcade_body_entered(body):
	if body.is_in_group("Player"):
		atAsteroids = true
		SignalManager.emit_signal("At_Asteroids")

func _on_AsteroidsArcade_body_exited(body):
	if body.is_in_group("Player"):
		atAsteroids = false
		SignalManager.emit_signal("LeftArcade")

func _on_PongArcade_body_entered(body):
	if body.is_in_group("Player"):
		atPong = true
		SignalManager.emit_signal("At_Pong")

func _on_PongArcade_body_exited(body):
	if body.is_in_group("Player"):
		atPong = false
		SignalManager.emit_signal("LeftArcade")

func _on_WaitTimer_timeout():
#	$Enemy/AnimationPlayer.play(anim_types[randi() % anim_types.size()])
	play_random_animation($Enemy/AnimationPlayer)

func play_random_animation(animation_player:AnimationPlayer):
    var animation_list = animation_player.get_animation_list()
    var random_animation = animation_list[randi() % animation_list.size()]
    animation_player.play(random_animation)

func _on_AnimationPlayer_animation_finished(anim_name):
	$WaitTimer.start()


