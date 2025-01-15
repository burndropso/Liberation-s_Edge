extends State
class_name PlayerHurt

@export var player : CharacterBody2D
@onready var anim = $"../../anim"
@onready var fsm = $".."
@onready var stab = $"../attack/player_attack/stab"


func Enter():	
	
	# knockback para a direcao certa
	player.velocity = Globals.knockback_vec
	if (Globals.player_facing_dir > 0 and Globals.knockback_vec.x > 0) or (Globals.player_facing_dir < 0 and Globals.knockback_vec.x < 0):
		anim.scale.x *= -1
		fsm.scale.x *= -1
		Globals.player_facing_dir *= -1
		
	anim.play('hurt')
	
	
func Update(_delta):
	await anim.animation_finished
	Transitioned.emit(self, 'idle')

 

	
	
