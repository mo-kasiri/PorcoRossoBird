extends Node2D
class_name Spawner

signal on_obstacle_crash;

@onready var timer: Timer = $Timer

const OBSTACLE = preload("uid://bvtnvi3vd8r6l")
var _is_game_started = false;

func create_obstacles():
	var obs = OBSTACLE.instantiate()
	obs.on_plane_crash.connect(_on_plane_crash)
	
	var viewport: Rect2 = get_viewport_rect()
	obs.position.x = viewport.end.x + 150
	
	var half = viewport.size.y / 2;
	obs.position.y = randf_range(half + 240, half - 50)
	add_child(obs)

func _on_timer_timeout() -> void:
	if not _is_game_started:
		return;
	#print("Timer timeout")
	create_obstacles()

func _ready() -> void:
	print("Spawner is ready")


func _on_player_on_game_started() -> void:
	_is_game_started = true;

func _stop_obstacles() -> void:
	timer.stop()
	
	for obs: Obstacle in get_children().filter(func(x): return x is Obstacle):
		obs.set_speed(0)

func _on_plane_crash()-> void:
	on_obstacle_crash.emit();
	_stop_obstacles()
