extends State

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var player = get_tree().current_scene.get_node('player')
@onready var shoot_raycast = $shoot_raycast
@onready var shoot_cooldown = $shoot_cooldown

func Enter():
	enemy.velocity.x = 0	
	anim.play('idle')


func Update(_delta):
	if enemy.velocity.y != 0:
		Transitioned.emit(self, 'fall')
	elif enemy.spotted_player and Globals.player_health > 0:
		Transitioned.emit(self, 'follow_player')
	elif shoot_raycast.is_colliding() and shoot_cooldown.is_stopped():
		shoot_cooldown.start()
		Transitioned.emit(self, 'shoot')
