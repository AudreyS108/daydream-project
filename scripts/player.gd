extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -500.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_player1: AudioStreamPlayer2D = $AudioStreamPlayer1
@onready var audio_player2: AudioStreamPlayer2D = $AudioStreamPlayer2
@onready var label: Label = $Camera2D/Label

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED

		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _input(event):
	
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_RIGHT or event.keycode == KEY_D: 
			sprite.flip_h = true  
		if event.keycode == KEY_LEFT or event.keycode == KEY_A:  
			sprite.flip_h = false  
