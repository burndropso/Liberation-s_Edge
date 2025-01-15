extends State
class_name WerewolfIdle

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var player = owner.get_parent().get_parent().get_node('player')

const CAN_SEE_PLAYER = 200

var distance

func Enter():
	anim.play("idle_human")
	 
	
func Update(_delta):
	distance = enemy.global_position.distance_to(player.global_position)
	if distance < CAN_SEE_PLAYER and Globals.player_health > 0 :
		anim.play("transformation")
		await anim.animation_finished
		Transitioned.emit(self, 'follow_player')
	
func Physics_Update(_delta):
	enemy.velocity.x = 0	
