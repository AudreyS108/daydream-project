extends Node2D

@export var animationPlr : AnimationPlayer 
@export var autoplay = false

@export var game_scene: PackedScene

@onready var audioPLR : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audioPLR2 : AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var audioPLR3 : AudioStreamPlayer2D = $AudioStreamPlayer2D3

@onready var bgMusic : AudioStreamPlayer2D = $AudioStreamPlayer1

@onready var button1 : Button = $UI/Panel/Panel1/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	# Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
		

func _playSound():
	audioPLR.stream = load("res://assets/Sounds/creepymoosic.wav")
	audioPLR.play()
	
func _playSound2():
	audioPLR2.stream = load("res://assets/Sounds/nono (1).wav")
	audioPLR2.play()
	await get_tree().create_timer(2).timeout
	audioPLR2.stop()
	audioPLR3.stream = load("res://assets/Sounds/crunchie mm.mp3")
	audioPLR3.play()

func _playSound3():
	audioPLR3.stream = load("res://assets/Sounds/electric-buzz-8456.mp3")
	audioPLR3.play()
	
func _changeScene1():
	get_tree().change_scene_to_packed(game_scene) 
	
	
func _on_button1_pressed() -> void:
	_changeScene1()
	
