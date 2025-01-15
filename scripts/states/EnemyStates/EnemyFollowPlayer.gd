extends State
class_name EnemyPlayerFollow

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var player : CharacterBody2D = owner.get_parent().get_parent().get_node('player')
@onready var collision = $"../../collision"
@onready var fsm = $".."

const CAN_SEE_PLAYER = 200
const SPEED = 70.0
const AIR_FRICTION = 0.5
const ATTACK_DISTANCE = 50

var bruh = 1
var distance
var direction
var has_to_die = false

func Enter():
	anim.play("walk")


func Update(_delta):
	distance = enemy.global_position.distance_to(player.global_position)
	var dir_to_player = enemy.global_position.direction_to(player.global_position)
	
	if distance <= ATTACK_DISTANCE and Globals.player_health > 0:
		Transitioned.emit(self, 'attack')	
	elif distance >= CAN_SEE_PLAYER or abs(dir_to_player.x) < 0.1:
		enemy.spotted_player = false
		Transitioned.emit(self, 'idle')
	elif enemy.velocity.y != 0:
		Transitioned.emit(self, 'fall')
	
func Physics_Update(_delta):
	
	enemy.check_dir()

	if enemy.enemy_dir:
		enemy.velocity.x = lerp(enemy.velocity.x, enemy.enemy_dir * SPEED, AIR_FRICTION)
	else:
		enemy.velocity.x = move_toward(enemy.velocity.x, 0, SPEED)

func _on_hurtbox_area_entered(area):
	if area.name == 'player_attack':
		has_to_die = true
