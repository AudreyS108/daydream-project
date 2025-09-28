extends AnimatedSprite2D


@onready var animation_player = $AnimationPlayer

func _input(event):
	# Check if the specified key is pressed (e.g., "F" key)
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_RIGHT:  # Replace KEY_F with your desired key
			flip_h = true  # Toggle horizontal flip
		if event.keycode == KEY_LEFT:  # Replace KEY_F with your desired key
			flip_h = false  # Toggle horizontal flip
		if event.keycode == KEY_F:
			animation_player.play("Holding")

# Called when the node enters the scene tree for the first time.
# 10 9 8 7 6 ... thing on animation?


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
