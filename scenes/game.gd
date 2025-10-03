extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


@onready var player_sprite: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var audio_player1: AudioStreamPlayer2D = $Player/AudioStreamPlayer1
@onready var audio_player2: AudioStreamPlayer2D = $Player/AudioStreamPlayer2
@onready var label: Label = $Player/Camera2D/Label

@onready var mouth_sprite: AnimatedSprite2D = $Mouth/AnimatedSprite2D

@onready var Hotdog1: Area2D = $Area1
@onready var Hotdog2: Area2D = $Area2

var is_colliding_with_area1 = false
var is_colliding_with_area2 = false
var sacrifices = 0

func _on_area1_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player entered the area!")
		is_colliding_with_area1 = true
	
func _on_area1_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("Player exited the area!")
		is_colliding_with_area1 = false
		
		
func _on_area2_body_entered(body: Node2D) -> void:
	is_colliding_with_area2 = true

func _on_area2_body_exited(body: Node2D) -> void:
	is_colliding_with_area2 = false
	
	
		
func _on_mouth_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player entered the area2!")
		is_colliding_with_area2 = true

func _on_mouth_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("Player exited the area!")
		is_colliding_with_area2 = false

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_F and is_colliding_with_area1: # and is colliding with hotdog ADD
			if event.keycode == KEY_F and is_colliding_with_area1 == false:
				player_sprite.play("Idle")
			player_sprite.play("Holding1")
			print("Play anim")
			audio_player1.stream = load("res://assets/Sounds/nono (1).mp3")
			audio_player1.play()
			Hotdog1.queue_free()
			
		if event.keycode == KEY_F and is_colliding_with_area2: # and is colliding with hotdog ADD
			if event.keycode == KEY_F and is_colliding_with_area2 == false:
				player_sprite.play("Idle")
			player_sprite.play("Holding2")
			print("Play anim")
			audio_player1.stream = load("res://assets/Sounds/nono (1).mp3")
			audio_player1.play()
			Hotdog2.queue_free()
		
		if event.keycode == KEY_X:
			if is_colliding_with_area2 == false:
				sacrifices = sacrifices
				label.text = "Hotdogs sacrificed: " + str(sacrifices)
				audio_player2.stop()
			if is_colliding_with_area2 == true : #and player_sprite.animation == "Holding"
				mouth_sprite.play("With_Ketchup")
				
				player_sprite.play("Idle")
				audio_player1.stop()
				audio_player2.stream = load("res://assets/Sounds/crunchie mm.mp3")
				audio_player2.play()
				
				sacrifices = sacrifices + 1
				print("text set")
				label.text = "Hotdogs sacrificed: " + str(sacrifices)
				is_colliding_with_area2 = false
				
				await get_tree().create_timer(1.5).timeout
				mouth_sprite.play("With_some_ketchup")
		
		
		
		
		
	
