extends State

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var player : CharacterBody2D = get_tree().current_scene.get_node('player')
@onready var shoot_cooldown = $'../idle/shoot_cooldown'

const CAN_SEE_PLAYER = 800	
const ATTACK_DISTANCE = 80

const SPEED = 70.0
const AIR_FRICTION = 0.5

func Enter():
	anim.play('run')

func Update(_delta):
	var distance = enemy.global_position.distance_to(player.global_position)
	var dir_to_player = enemy.global_position.direction_to(player.global_position)
	
	if enemy.velocity.y != 0:
		Transitioned.emit(self, 'fall')	
	elif distance <= ATTACK_DISTANCE and Globals.player_health > 0:
		Transitioned.emit(self, 'attack')
	elif shoot_cooldown.is_stopped():
		shoot_cooldown.start()
		Transitioned.emit(self, 'shoot')
	elif distance >= CAN_SEE_PLAYER or abs(dir_to_player.x) < 0.1:
		enemy.spotted_player = false
		Transitioned.emit(self, 'idle')


func Physics_Update(_delta):
	enemy.check_dir()
	if enemy.enemy_dir:
		enemy.velocity.x = lerp(enemy.velocity.x, enemy.enemy_dir * SPEED, AIR_FRICTION)
	else:
		enemy.velocity.x = move_toward(enemy.velocity.x, 0, SPEED)
