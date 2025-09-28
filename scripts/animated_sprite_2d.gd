extends AnimatedSprite2D

@onready var audio_player1 = $AudioStreamPlayer1
@onready var collisionarea = $Area2d
@onready var audio_player2 = $AudioStreamPlayer2

var is_colliding_with_area2d = false

func _ready() -> void:
	if collisionarea:
		collisionarea.body_entered.connect(_on_hotdog_body_entered)
		
	


func _on_hotdog_body_entered(body: Node) -> void:
	if body.name == "Player":
		is_colliding_with_area2d = true
		print("Player entered area!")

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _input(event):
	
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_RIGHT: 
			flip_h = true  
		if event.keycode == KEY_LEFT:  
			flip_h = false  
		if event.keycode == KEY_F and is_colliding_with_area2d: # and is colliding with hotdog ADD
			self.play("Holding")
			audio_player1.stream = load("res://assets/Sounds/nono (1).mp3")
			audio_player1.play()
		elif event.keycode == KEY_F and is_colliding_with_area2d == false:
			self.play("Idle")
			
		if event.keycode == KEY_X and self.is_playing() == true:
			self.play("Idle")
			audio_player1.stop()
			audio_player2.stream = load("res://assets/Sounds/crunchie mm.mp3")
			audio_player2.play()
			

func _process(delta: float) -> void:
	pass
