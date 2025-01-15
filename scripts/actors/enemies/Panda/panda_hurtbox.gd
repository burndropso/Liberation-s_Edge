extends Area2D

@export var enemy : CharacterBody2D
@export var shield_fsm : Node2D


func _on_area_entered(area):
	if area.name == 'player_attack':
			enemy.take_damage(Globals.WEAPONS.find_key(Globals.weapon)) # key name of current weapon being used by player
	elif area.is_in_group('bullets') and shield_fsm.current_state.get_name() == 'shield_off':
		#if area.get_node('anim').animation == 'player_bullet':
		enemy.take_damage('GUN')
