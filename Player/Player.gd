extends CharacterBody2D

const BASE_SPEED := 900.0
const MAX_SPEED := 15000.0
const ROTATION_SPEED := 1.0
const STOP_THRESHOLD := 50.0
const ACCELERATION_FACTOR := 3.0
var health = 5

#Worm Length
var worm_data : Array
var worm_segment = preload("res://Player/worm_segment.tscn")
const SEGMENT_SIZE = 125

signal updateUI(change)
signal gameOver()

func _ready():
	generate_worm()
func _physics_process(delta):
	var rotation_direction = Input.get_axis("left", "right")

	rotation += rotation_direction * ROTATION_SPEED * delta

	var cursor_position = get_global_mouse_position()
	var distance_to_cursor = position.distance_to(cursor_position)

	var speed = 0
	if distance_to_cursor > STOP_THRESHOLD:
		var speed_ratio = min(distance_to_cursor / (MAX_SPEED - BASE_SPEED), 1.0)
		speed = BASE_SPEED + speed_ratio * (MAX_SPEED - BASE_SPEED) * ACCELERATION_FACTOR

	speed = min(speed, MAX_SPEED)

	var movement_direction = Vector2(0, -1).rotated(rotation)
	velocity = movement_direction * speed * delta

	move_and_slide()
	
func generate_worm():
	worm_data.clear()
	health = 5
	updateUI.emit(health)
	
	for i in range(health):
		add_segment()
		print("Segment Added")
		
func add_segment():
	var wormSegment = worm_segment.instantiate()
	wormSegment.position = Vector2(0, (worm_data.size() * SEGMENT_SIZE))
	add_child(wormSegment)
	worm_data.append(wormSegment)
	
func remove_segment():
	remove_child(worm_data[-1])
	worm_data.resize(worm_data.size() - 1)
	
func addHealth():
	health += 1
	updateUI.emit(1)
	add_segment()

func removeHealth():
	health -= 1
	if(health == 0):
		gameOver.emit()
	else:
		remove_segment()
		updateUI.emit(-1) 

#These two are for testing purposes
func _on_remove_health_pressed():
	removeHealth()
func _on_add_health_pressed():
	addHealth()
