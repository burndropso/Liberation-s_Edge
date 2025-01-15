extends State

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var player = get_tree().current_scene.get_node('player')
@onready var shoot_raycast = $shoot_raycast
@onready var shoot_cooldown = $shoot_cooldown

var dir_to_player

func Enter():
	enemy.velocity.x = 0	
	anim.play('idle')


func Update(_delta):
	dir_to_player = enemy.global_position.direction_to(player.global_position)
	
	if enemy.velocity.y != 0:
		Transitioned.emit(self, 'fall')
	elif shoot_raycast.is_colliding() and shoot_cooldown.is_stopped():
		shoot_cooldown.start()
		Transitioned.emit(self, 'shoot')

func Physics_Update(_delta):
	if enemy.spotted_player:
		enemy.check_dir()
