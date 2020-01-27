extends Node

export (PackedScene) var Mob
var A_SpawnTime = 1
var localScore = 0
func _ready():
	randomize()
	SignalManager.connect("OpenAsteroids", self, "OpenAsteroids")
	SignalManager.connect("CloseAsteroids", self, "CloseAsteroids")

func _process(delta):
	$localScore.set_text(str(localScore))

func CloseAsteroids():
	Global.PlayAsteroids = false
	if localScore > Global.A_High:
		Global.A_High = localScore

func OpenAsteroids():
	Global.PlayAsteroids = true
	A_SpawnTime = 1
	localScore = 0
	$Timer.start()

func _on_Boundry_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill()

func _on_Timer_timeout():
    # Choose a random location on Path2D.
    $Path2D/PathFollow2D.set_offset(randi())
    # Create a Mob instance and add it to the scene.
    var mob = Mob.instance()
    add_child(mob)
    # Set the mob's direction perpendicular to the path direction.
    var direction = $Path2D/PathFollow2D.rotation + PI / 2
    # Set the mob's position to a random location.
    mob.position = $Path2D/PathFollow2D.position
    # Add some randomness to the direction.
#    direction += rand_range(-PI / 8, PI / 8)
    mob.rotation = direction
    # Set the velocity (speed & direction).
    mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
    mob.linear_velocity = mob.linear_velocity.rotated(direction)
    A_SpawnTime -= 0.025
    if A_SpawnTime <= 0.2:
        A_SpawnTime = 0.25
    $Timer.set_wait_time(A_SpawnTime)
    if 	Global.PlayAsteroids == true:
        $Timer.start()
    else:
        $Timer.stop()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill()

func _on_Score_body_entered(body):
	if body.is_in_group("Enemy") and Global.PlayAsteroids == true:
		localScore += 1
