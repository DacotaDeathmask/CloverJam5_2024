extends CharacterBody2D

const SPEED = 300.0
const ROTATION_SPEED = 1.0
var health = 10

signal updateUI(change)
signal updateCurve(change)
signal gameOver()

func _physics_process(delta):
	var forward_movement = Input.get_axis("ui_down", "ui_up")
	var rotation_direction = Input.get_axis("ui_left", "ui_right")

	rotation += rotation_direction * ROTATION_SPEED * delta

	var movement_direction = Vector2(0, -1).rotated(rotation)
	velocity = movement_direction * forward_movement * SPEED


	move_and_slide()

func addHealth():
	health += 1
	updateUI.emit(1)
	updateCurve.emit(1)

func removeHealth():
	health -= 1
	if(health == 0):
		gameOver.emit()
	else:
		updateUI.emit(-1) 
		updateCurve.emit(-1)

#These two are for testing purposes
func _on_remove_health_pressed():
	removeHealth()
func _on_add_health_pressed():
	addHealth()
