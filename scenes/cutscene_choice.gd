extends Node2D

@export var animationPlr : AnimationPlayer
@export var autoplay = false
@export var gameplay_Scene: PackedScene

@onready var audioPLR : AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _changeScene():
	get_tree().change_scene_to_packed(gameplay_Scene) # FIX HERE

func _playSound():
	audioPLR.stream = load("res://assets/Sounds/StartCutsceneAudio.mp3")
	audioPLR.play()
