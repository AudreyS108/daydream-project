extends Node2D

@export var animationPlr : AnimationPlayer 
@export var autoplay = false

@export var other_scene : PackedScene
@export var self_scene : PackedScene

@onready var audioPLR : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audioPLR2 : AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var audioPLR3 : AudioStreamPlayer2D = $AudioStreamPlayer2D3

@onready var bgMusic : AudioStreamPlayer2D = $AudioStreamPlayer1

@onready var button1 : Button = $UI/Panel/Panel1/Button
@onready var button2 : Button = $UI/Panel/Panel2/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	# Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func pause():
	if autoplay == false:
		animationPlr.pause()
		
func _input(event):
	if event.is_action_pressed("next") and not animationPlr.is_playing():
		animationPlr.play()

func _playSound():
	audioPLR.stream = load("res://assets/Sounds/creepymoosic.wav")
	audioPLR.play()
	
func _playSound2():
	audioPLR2.stream = load("res://assets/Sounds/LastHotdogPT1.mp3")
	audioPLR2.play()
	

func _playSound3():
	audioPLR3.stream = load("res://assets/Sounds/LastHotdogPT2.mp3")
	audioPLR3.play()
	
func _changeScene1():
	get_tree().change_scene_to_packed(other_scene) # FIX HERE
	
func _changeScene2():
	get_tree().change_scene_to_packed(self_scene) # FIX HERE

func _on_button1_pressed() -> void:
	_changeScene1()
	

func _on_button2_pressed() -> void:
	_changeScene2()
