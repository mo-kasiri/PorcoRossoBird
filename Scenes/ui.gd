extends CanvasLayer

class_name UI

@onready var label: Label = $MarginContainer/Label
@onready var start_menu: Control = $StartMenu
@onready var game_over: Control = $GameOver

func ready() -> void:
	label.text = "0";
	game_over.hide();
	
func update_score(point: int):
	label.text = str(point);
	
#region public methods
func show_gameover() -> void:
	game_over.show();
	pass
#endregion
