extends Node2D

@onready var player: Player = $Player
@onready var spawner: Spawner = $Spawner
@onready var ui: UI = $UI

static var score: int;
static var best_score: int;

func restart(_best_score: int):
	pass


func _on_player_on_game_started() -> void:
	print("The Game is started")
	ui.start_menu.hide();

func _on_spawner_on_obstacle_crash() -> void:
	player.stop_movement()
	#ui.show_gameover()

func _on_ground_on_player_crash() -> void:
	spawner._stop_obstacles()
	ui.show_gameover()

func _on_spawner_on_add_player_score() -> void:
	score += 1;
	if score > best_score:
		best_score = score;
		ui.score_best.text = str(best_score);
	ui.update_score(score)
