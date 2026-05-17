extends Node2D
class_name Ground

signal on_player_crash;

@export var speed := -150;

@onready var ground_hit_sound: AudioStreamPlayer2D = $GroundHitSound
@onready var ground_1: Area2D = $Ground1
@onready var ground_2: Area2D = $Ground2
@onready var sprite_2d: Sprite2D = %Sprite2D

var texture_width: int;

func _ready():
	texture_width = sprite_2d.texture.get_width();

func _process(delta: float) -> void:
	ground_1.global_position.x += speed * delta;
	ground_2.global_position.x += speed * delta;
		
	if ground_1.global_position.x < -texture_width/2:
		ground_1.global_position.x = ground_2.global_position.x + texture_width;
		
	if ground_2.global_position.x < -texture_width/2:
		ground_2.global_position.x = ground_1.global_position.x + texture_width;

func _on_spawner_on_obstacle_crash() -> void:
	speed = 0;

func _on_ground_body_entered(body: Node2D) -> void:
	on_player_crash.emit();
	ground_hit_sound.play()
	speed = 0;
	var player_ref: Player = body as Player
	player_ref.stop_movement()
	player_ref._stop_gravity()
