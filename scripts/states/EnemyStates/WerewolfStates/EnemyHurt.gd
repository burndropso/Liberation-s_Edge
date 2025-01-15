extends State
class_name WerewolfHurt

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var anim_combat = $"../../anim_combat"

func Enter():
	enemy.velocity.x = 0
	anim_combat.stop()
	anim.play('hurt')
	

func Physics_Update(delta):
	
	await anim.animation_finished
	Transitioned.emit(self, 'idle')
