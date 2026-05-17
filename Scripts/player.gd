extends CharacterBody2D
class_name Player

const PI: float = 3.141592653589793;

signal on_game_started;

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_audio: AudioStreamPlayer2D = $JumpAudio

@export var gravity : float = 1000;
@export var jump_force: float = -400
@export var max_speed: float = 600
@export var rotation_speed: float = 6
static  var player_point: int = 0;

@export var is_started: bool = false;
@export var should_process_input: bool = true;

#region private_methods
func _rotate_player(deg: float, delta: float) -> float:
	return move_toward(
			rotation,
			deg,
			rotation_speed * delta
		)
		
func _input_process():
	if (Input.is_action_just_pressed("jump") and should_process_input):
		jump_audio.play();
		velocity.y = jump_force;
		if not is_started:
			is_started = true;
			animated_sprite_2d.play("move")
			on_game_started.emit();
		
#endregion

func _physics_process(delta: float) -> void:
	_input_process()
	
	if not is_started:
		return;
	
	# Apply gravity
	velocity.y += gravity * delta;
	velocity.y = min(velocity.y, max_speed)
	move_and_slide()
	
	# Apply rotation
	rotation = _rotate_player(sign(velocity.y) * PI/6, delta)


func _add_point():
	player_point += 1;
	
func _stop_movement() ->void:
	should_process_input = false;
	animated_sprite_2d.play("idle")
	
func _stop_gravity() -> void:
	gravity = 0
	velocity = Vector2.ZERO

func stop_movement() -> void:
	print("stop player")
	#_stop_gravity();
	_stop_movement();
