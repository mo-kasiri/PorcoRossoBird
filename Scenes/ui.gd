extends CanvasLayer

class_name UI
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var start_menu: Control = $StartMenu
@onready var game_over_container: VBoxContainer = %GameOver
@onready var score_final: Label = %ScoreFinal
@onready var score_best: Label = %ScoreBest


func _ready() -> void:
	score_label.text = "0";
	game_over_container.hide()
	print("hide game over")

	
func update_score(point: int):
	score_final.text = str(point);
	score_label.text = str(point);
	
#region public methods
func show_gameover() -> void:
	game_over_container.show()
	score_label.hide();
	pass
#endregion


func _on_ok_button_pressed() -> void:
	get_tree().reload_current_scene()
