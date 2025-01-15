extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func flash():
	animation_player.play("flash")
