extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("At_Asteroids", self, "At_Asteroids")
	SignalManager.connect("At_Pong", self, "At_Pong")
	SignalManager.connect("LeftArcade", self, "LeftArcade")
	
	$D_Screen.show()
	$Default.show()
	
func At_Asteroids():
	$A_Screen.show()
	$AText.show()
	$P_Screen.hide()
	$PText.hide()
	$D_Screen.hide()
	$Default.hide()


func At_Pong():
	$A_Screen.hide()
	$AText.hide()
	$P_Screen.show()
	$PText.show()
	$D_Screen.hide()
	$Default.hide()


func LeftArcade():
	$A_Screen.hide()
	$AText.hide()
	$P_Screen.hide()
	$PText.hide()
	$D_Screen.show()
	$Default.show()
