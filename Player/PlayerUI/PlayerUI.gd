extends Control

const HEALTH_TEXT = "Health: "
var health = 0

func _on_player_update_ui(change):
	health += change
	$Health.text = HEALTH_TEXT + str(health)
