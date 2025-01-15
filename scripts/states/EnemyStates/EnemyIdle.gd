extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"

func Enter():
	enemy.velocity.x = 0	
	anim.play("idle")
	
func Update(_delta):
	if enemy.velocity.y != 0:
		Transitioned.emit(self, 'fall')
	elif enemy.spotted_player and Globals.player_health > 0:
		Transitioned.emit(self, 'follow_player')
	
