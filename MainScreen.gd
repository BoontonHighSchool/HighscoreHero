extends Node

onready var GameViewport = $VBoxContainer/HBoxContainer/ViewportContainer/GameViewport
onready var PongGame = $VBoxContainer/HBoxContainer/ViewportContainer/GameViewport/PongGame
onready var DefaultScreen = $VBoxContainer/HBoxContainer/ViewportContainer/GameViewport/DefaultArcade
onready var AsteroidsGame = $VBoxContainer/HBoxContainer/ViewportContainer/GameViewport/Asteroids

func _ready():
	SignalManager.connect("OpenPong", self, "OpenPong")
	SignalManager.connect("ClosePong", self, "ClosePong")
	SignalManager.connect("OpenAsteroids", self, "OpenAsteroids")
	SignalManager.connect("CloseAsteroids", self, "CloseAsteroids")
	SignalManager.connect("LeftArcade", self, "LeftArcade")
	DefaultScreen.show()
	PongGame.hide()
	AsteroidsGame.hide()

func OpenPong():
	PongGame.show()
	DefaultScreen.hide()
	AsteroidsGame.hide()
	
func ClosePong():
	DefaultScreen.show()
	PongGame.hide()
	AsteroidsGame.hide()
	
func OpenAsteroids():
	AsteroidsGame.show()
	DefaultScreen.hide()
	PongGame.hide()
	
func CloseAsteroids():
	AsteroidsGame.hide()
	DefaultScreen.show()
	PongGame.hide()
	
func LeftArcade():
	DefaultScreen.show()
	PongGame.hide()
	AsteroidsGame.hide()