extends Node2D

@onready var player_sprite: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var audio_player1: AudioStreamPlayer2D = $Player/AudioStreamPlayer1
@onready var audio_player2: AudioStreamPlayer2D = $Player/AudioStreamPlayer2

@onready var mouth: AnimatedSprite2D = $Mouth/AnimatedSprite2D

@onready var label: Label = $CanvasLayer/Control/Label

@onready var X_toKill: Sprite2D = $MouthArea/CollisionShape2D/XSign

@onready var hotdogs := {
	"area1": {
		"node": $Area1,
		"speech": $Area1/Sprite2D/Speechbubble2,
		"held_animation": "Holding1"
	},
	"area2": {
		"node": $Area2,
		"speech": $Area2/Sprite2D/Speechbubble2,
		"held_animation": "Holding2"
	}
}

var current_area = ""
var nearMouthOutside= false
var sacrifices = 0

func _ready() -> void:
	for hotdog in hotdogs.values():
		hotdog["speech"].visible = false
	X_toKill.visible = false

func _on_area_body_entered(area_name: String, body: Node2D) -> void:
	if body.name != "Player": return

	if player_sprite.animation == "Idle":
		current_area = area_name
		hotdogs[area_name]["speech"].visible = true
	else:
		current_area = ""

func _on_area_body_exited(area_name: String, body: Node2D) -> void:
	if body.name != "Player": return

	if current_area == area_name:
		current_area = ""
	hotdogs[area_name]["speech"].visible = false

func _on_area1_body_entered(body): _on_area_body_entered("area1", body)
func _on_area1_body_exited(body): _on_area_body_exited("area1", body)
func _on_area2_body_entered(body): _on_area_body_entered("area2", body)
func _on_area2_body_exited(body): _on_area_body_exited("area2", body)

func _on_mouth_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		nearMouthOutside = true
		X_toKill.visible = true

func _on_mouth_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		nearMouthOutside = false
		X_toKill.visible = false

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_F:
				if current_area != "":
					var hotdog = hotdogs[current_area]
					player_sprite.play(hotdog["held_animation"])
					audio_player1.stream = load("res://assets/Sounds/nono (1).mp3")
					audio_player1.play()
					hotdog["node"].queue_free()
					hotdog["speech"].visible = false
					current_area = ""
			KEY_X:
				if not nearMouthOutside:
					label.text = "Hotdogs sacrificed: %d" % sacrifices
					audio_player2.stop()
				elif player_sprite.animation.begins_with("Holding"):
					await _killhotdog()

func _killhotdog() -> void:
	mouth.play("With_Ketchup")
	player_sprite.play("Idle")
	audio_player1.stop()
	audio_player2.stream = load("res://assets/Sounds/crunchie mm.mp3")
	audio_player2.play()

	sacrifices += 1
	label.text = "Hotdogs sacrificed: %d" % sacrifices
	await get_tree().create_timer(1.5).timeout

	mouth.play("Default")
	audio_player2.stop()
