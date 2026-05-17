extends CanvasLayer

class_name UI

#region Assets reference
const MEDAL_BRONZE = preload("uid://b2akkjgeahful")
const MEDAL_SILVER = preload("uid://be7nyiw44n3bu")
const MEDAL_GOLD = preload("uid://c5q8rpg33holx")
#endregion

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var start_menu: Control = $StartMenu
@onready var game_over_container: VBoxContainer = %GameOver
@onready var score_final: Label = %ScoreFinal
@onready var score_best: Label = %ScoreBest
@onready var medal_image: TextureRect = %MedalImage
@onready var click_ok_sound: AudioStreamPlayer2D = $GameOver/ClickOKSound


func _ready() -> void:
	score_label.text = "0";
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
	click_ok_sound.play()
	
	get_tree().reload_current_scene()

func calculate_score(amount: int, high: int) -> void:
	score_final.text = str(amount);
	if amount >= 20:
		medal_image.texture = MEDAL_GOLD
	elif amount >= 10:
		medal_image.texture = MEDAL_SILVER
	else:
		medal_image.texture = MEDAL_BRONZE
		
	score_best.text = str(high)
