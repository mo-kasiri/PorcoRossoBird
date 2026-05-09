extends Node2D

signal on_plane_crash;

@export var move_speed: float = 150;

var _is_game_started: bool = false;

func _process(delta: float) -> void:
	if _is_game_started:
		position.x -= move_speed * delta;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_player_on_game_started() -> void:
	_is_game_started = true;

func _on_top_body_entered(body: Node2D) -> void:
	if not body is Player:
		return;
	on_plane_crash.emit();
	print(" top collision")


func _on_bottom_body_entered(body: Node2D) -> void:
	if not body is Player:
		return;
	on_plane_crash.emit();
	print("bottom collision")
