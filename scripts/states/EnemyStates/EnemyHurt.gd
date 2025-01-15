extends State
class_name EnemyHurt

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var anim_combat = $"../../anim_combat"
@onready var player = get_tree().current_scene.get_node('player')
var KNOCKBACK_VEC = Vector2(50, -100)

func Enter():
	enemy.velocity.x = 0
	if anim_combat.is_playing():
		anim_combat.stop()
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
