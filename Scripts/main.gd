extends Node2D

@onready var player: Player = $Player


func _on_player_on_game_started() -> void:
	print("The Game is started")


func _on_spawner_on_obstacle_crash() -> void:
	player.stop_movement()
