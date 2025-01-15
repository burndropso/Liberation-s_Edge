extends Area2D

@export var enemy : CharacterBody2D
@export var enemy_anim : AnimatedSprite2D

func _on_area_entered(area):
	if area.name == 'player_attack':
		enemy.take_damage(Globals.WEAPONS.find_key(Globals.weapon)) # key name of current weapon being used by player
	elif area.is_in_group('bullets'):
		if area.get_node('anim').animation == 'player_bullet':
			enemy.take_damage('GUN')
		
