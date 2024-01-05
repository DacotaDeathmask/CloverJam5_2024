extends CharacterBody2D

const SPEED = 300.0
var health = 10

signal updateUI(change)
signal updateCurve(change)
signal gameOver()

func _physics_process(delta):
	var Xdirection = Input.get_axis("ui_left", "ui_right")
	var Ydirection = Input.get_axis("ui_up", "ui_down")
	
	if Xdirection:
		velocity.x = Xdirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Ydirection:
		velocity.y = Ydirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

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
