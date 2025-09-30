extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_player1: AudioStreamPlayer2D = $AnimatedSprite2D/AudioStreamPlayer1
@onready var audio_player2: AudioStreamPlayer2D = $AnimatedSprite2D/AudioStreamPlayer2
@onready var collisionarea: Area2D = $AnimatedSprite2D/hotdog
@onready var label: Label = $Camera2D/Label

var is_colliding_with_area2d = false
var is_colliding_with_area2d2 = false
var sacrifices = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player entered the area!")
		is_colliding_with_area2d = true
		

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player entered the area2!")
		is_colliding_with_area2d2 = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("Player exited the area!")
		is_colliding_with_area2d = false

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("Player exited the area!")
		is_colliding_with_area2d2 = false

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
		if event.keycode == KEY_RIGHT: 
			sprite.flip_h = true  
		if event.keycode == KEY_LEFT:  
			sprite.flip_h = false  
			
		if event.keycode == KEY_F and is_colliding_with_area2d: # and is colliding with hotdog ADD
			if event.keycode == KEY_F and is_colliding_with_area2d == false:
				sprite.play("Idle")
			sprite.play("Holding")
			audio_player1.stream = load("res://assets/Sounds/nono (1).mp3")
			audio_player1.play()
			
		if event.keycode == KEY_X:
			if is_colliding_with_area2d2 == false:
				sacrifices = sacrifices
				label.text = "Hotdogs sacrificed: " + str(sacrifices)
			if is_colliding_with_area2d2 == true : #and sprite.animation == "Holding"
				sprite.play("Idle")
				audio_player1.stop()
				audio_player2.stream = load("res://assets/Sounds/crunchie mm.mp3")
				audio_player2.play()
				sacrifices = sacrifices + 1
				print("text set")
				label.text = "Hotdogs sacrificed: " + str(sacrifices)
				is_colliding_with_area2d2 = false
		
		
		
		
		
	
		
