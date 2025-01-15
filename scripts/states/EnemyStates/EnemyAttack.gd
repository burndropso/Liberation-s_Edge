extends State
class_name EnemyAttack


@export var enemy : CharacterBody2D
@onready var anim_combat = $"../../anim_combat"
@onready var player : CharacterBody2D = owner.get_parent().get_parent().get_node('player')

const ATTACK_DISTANCE = 50
var distance
var has_to_die
var is_hurted = false

func Enter():
	enemy.velocity.x = 0
	anim_combat.play("attack")
	
func Update(delta):
	distance = enemy.global_position.distance_to(player.global_position)
	if has_to_die:
		Transitioned.emit(self, 'die')
	elif is_hurted:
		is_hurted = false
		Transitioned.emit(self, 'hurt')
	elif distance > ATTACK_DISTANCE:
		Transitioned.emit(self, 'follow_player')
	elif Globals.player_health <= 0:
		Transitioned.emit(self, 'idle')
		
func Physics_Update(delta):
	anim_combat.play("attack")


func _on_hurtbox_area_entered(area):
	if area.name == 'player_attack':
		has_to_die = true


func _on_enemy_hitbox_area_entered(area):
	if area.name == 'parry':
		is_hurted = true

