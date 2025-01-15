extends State

@export var enemy : CharacterBody2D
@onready var player : CharacterBody2D = get_tree().current_scene.get_node('player')
@onready var anim = $"../../anim"
@onready var anim_combat = $"../../anim_combat"


const ATTACK_DISTANCE = 50
var distance
var has_to_die
var is_hurted = false
var parry_dir : bool

func Enter():
	enemy.velocity.x = 0
	
func Update(_delta):
	distance = enemy.global_position.distance_to(player.global_position)

	if has_to_die:
		Transitioned.emit(self, 'die')
	elif is_hurted:
		is_hurted = false
		Transitioned.emit(self, 'hurt')
	elif distance > ATTACK_DISTANCE:
		await anim_combat.animation_finished
		Transitioned.emit(self, 'follow_player')
	elif Globals.player_health <= 0:
		Transitioned.emit(self, 'idle')
		
func Physics_Update(_delta):
	
	anim_combat.play('melee')
	await anim_combat.animation_finished
	enemy.check_dir()


func _on_hurtbox_area_entered(area):
	if area.name == 'player_attack':
		has_to_die = true


func _on_enemy_hitbox_area_entered(area):
	if area.name == 'parry' and parry_dir and Globals.abilities['PARRY']:
		is_hurted = true
		

func is_player_facing_me(facing : bool):
	parry_dir = facing
	
