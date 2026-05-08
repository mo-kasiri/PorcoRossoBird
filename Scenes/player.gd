extends CharacterBody2D
const PI: float = 3.141592653589793;

#@onready var plane_sprite: Sprite2D = $Sprite2D

@export var gravity : float = 1000;
@export var jump_force: float = -400
@export var max_speed: float = 600
@export var rotation_speed: float = 6


#region private_methods
func _rotate_player(deg: float, delta: float) -> float:
	return move_toward(
			rotation,
			deg,
			rotation_speed * delta
		)
		
func _input_process():
	if (Input.is_action_just_pressed("jump")):
		velocity.y = jump_force;
#endregion

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += gravity * delta;
	velocity.y = min(velocity.y, max_speed)
	move_and_slide()
	
func _process(delta: float) -> void:
	if (velocity.y < 0):
		# It's falling
		rotation = _rotate_player(-PI/6, delta)
		pass
	else:
		rotation = _rotate_player(PI/6, delta)
		pass
	_input_process()
	

		
