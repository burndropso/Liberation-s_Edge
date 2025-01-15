extends Node2D

@onready var player := $player as CharacterBody2D
@onready var camera := $camera as Camera2D
@onready var border_limit = $border_limit
@onready var ui_weapon_selector = $UI/ui_weapon_selector
@onready var respawn = $respawn

func _ready():
	player.follow_camera(camera)
		
func _process(_delta):
	 
	if border_limit.is_colliding():
		var collider
		collider = border_limit.get_collider()
		
		if collider.is_in_group('player'):
			collider.global_position = respawn.global_position
		else:
			collider.queue_free()
