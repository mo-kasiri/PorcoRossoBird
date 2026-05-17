extends Node2D
class_name Obstacle

signal on_plane_crash;
signal on_add_score;
@onready var plane_crash_sound: AudioStreamPlayer2D = $PlaneCrashSound
@onready var collect_coin_sound: AudioStreamPlayer2D = $CollectCoinSound

@export var move_speed: float = 150.0;

#region public methods
func set_speed(value: float) -> void:
	move_speed = value;
#endregion

func _process(delta: float) -> void:
	#if _is_game_started:
	position.x -= move_speed * delta;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


#region Signals
func _on_player_on_game_started() -> void:
	#_is_game_started = true;
	pass
	
func _on_top_body_entered(body: Node2D) -> void:
	if not body is Player:
		return;
	on_plane_crash.emit();
	plane_crash_sound.play()
	print(" top collision")

func _on_bottom_body_entered(body: Node2D) -> void:
	if not body is Player:
		return;
	on_plane_crash.emit();
	plane_crash_sound.play()
	print("bottom collision")
#endregion

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_exit_area_body_exited(body: Node2D) -> void:
	collect_coin_sound.play()
	#Player.player_point += 1;
	#print(Player.player_point)
	on_add_score.emit();
