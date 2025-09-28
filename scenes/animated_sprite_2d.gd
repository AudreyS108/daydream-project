extends AnimatedSprite2D

@onready var audio_player = $AudioStreamPlayer1
@onready var animation_player = $AnimationPlayer
@onready var collisionarea = $hotdog

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _input(event):
	# Check if the specified key is pressed (e.g., "F" key)
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_RIGHT:  # Replace KEY_F with your desired key
			flip_h = true  # Toggle horizontal flip
		if event.keycode == KEY_LEFT:  # Replace KEY_F with your desired key
			flip_h = false  # Toggle horizontal flip
		if event.keycode == KEY_F: # and is colliding with hotdog ADD
			
				self.play("Holding")
				audio_player.stream = load("res://assets/Sounds/nono (1).mp3")
				audio_player.play()
		if event.keycode == KEY_X and self.is_playing() == true:
			self.play("Idle")
			audio_player.stop()
			
		
func collideWithhotdog() -> bool:
	if collisionarea:
		for body in collisionarea.get_overlapping_bodies():
			if body.is_in_group("otherhotdogs"):
				body.get_parent().queue_free()
				return true
	else:
		push_error("Area2D node not found!")
	return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
