extends Node2D




func _on_player_game_over():
	$"Health Buttons".queue_free()
	$Player.queue_free()
	$PlayerUi.queue_free()
	$"Game Over".visible = true
