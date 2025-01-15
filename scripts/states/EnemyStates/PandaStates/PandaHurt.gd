extends State

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var anim_combat = $"../../anim_combat"
@onready var player = get_tree().current_scene.get_node('player')
@onready var attack_collision = $'../attack/enemy_hitbox/collision'

var KNOCKBACK_VEC = Vector2(100, -100)

func Enter():
	enemy.velocity.x = 0
	
	anim_combat.stop()
	#combat_anim is interrupted and leaves the collision on
	attack_collision.set_deferred('disabled',true)
	
	anim.play('hurt')
	apply_knockback()
	

func Physics_Update(_delta):
	await anim.animation_finished
	Transitioned.emit(self, 'idle')

func apply_knockback():
	var dir : Vector2 = enemy.global_position.direction_to(player.global_position)
	enemy.velocity = KNOCKBACK_VEC
	if dir.x > 0:
		enemy.velocity.x = -enemy.velocity.x
