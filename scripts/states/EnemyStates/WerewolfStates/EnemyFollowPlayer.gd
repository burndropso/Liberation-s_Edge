extends State
class_name WerewolfPlayerFollow

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
	anim.play("run")


func Update(_delta):
	distance = enemy.global_position.distance_to(player.global_position)
	if has_to_die:
		Transitioned.emit(self, 'die')
	elif distance <= ATTACK_DISTANCE and Globals.player_health > 0:
		Transitioned.emit(self, 'attack')	
	elif distance >= CAN_SEE_PLAYER:
		Transitioned.emit(self, 'idle')
	
func Physics_Update(_delta):
	if enemy.global_position.x < player.global_position.x:
		direction = 1
		if bruh == -1:
			#enemy.scale.x *= -1
			anim.scale.x *= -1
			fsm.scale.x *= -1
			bruh = 1
		
	elif enemy.global_position.x > player.global_position.x:
		direction = -1
		if bruh == 1:
			#enemy.scale.x *= -1
			anim.scale.x *= -1
			fsm.scale.x *= -1
			bruh = -1	

	if direction:
		enemy.velocity.x = lerp(enemy.velocity.x, direction * SPEED, AIR_FRICTION)
	else:
		enemy.velocity.x = move_toward(enemy.velocity.x, 0, SPEED)


func _on_hurtbox_area_entered(area):
	if area.name == 'player_attack':
		has_to_die = true
