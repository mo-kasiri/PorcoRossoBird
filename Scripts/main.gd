extends Node2D

const SAVEFILE: String = "user://score.save"

@onready var player: Player = $Player
@onready var spawner: Spawner = $Spawner
@onready var ui: UI = $UI
@onready var main_theme_music: AudioStreamPlayer2D = $MainThemeMusic

static var score: int;
var best_score: int = 0

func _ready() -> void:
	load_highscore();
	ui.score_best.text = str(best_score)
	score = 0;
	main_theme_music.play()
	
func load_highscore():
	var file: FileAccess = FileAccess.open(SAVEFILE, FileAccess.READ)
	if file:
		best_score = file.get_32()

func save_score() -> void:
	if score > best_score:
		best_score = score;
		var file: FileAccess = FileAccess.open(SAVEFILE, FileAccess.WRITE)
		file.store_32(best_score)

func _on_player_on_game_started() -> void:
	print("The Game is started")
	ui.start_menu.hide();

func _on_spawner_on_obstacle_crash() -> void:
	player.stop_movement()
	#ui.show_gameover()

func _on_ground_on_player_crash() -> void:
	spawner._stop_obstacles()
	load_highscore()
	ui.calculate_score(score, best_score)
	ui.show_gameover()

func _on_spawner_on_add_player_score() -> void:
	score += 1;
	save_score();
	ui.update_score(score)
