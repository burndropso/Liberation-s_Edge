extends State
class_name PlayerHurtbox

signal enemy_position
@export var player : CharacterBody2D
@onready var anim_combat = $"../anim_combat"
@onready var collision = $player_hurt_area/collision

func _ready():
	enemy_position.connect(choose_knockback)

func _on_player_hurt_area_area_entered(area : Area2D ):
		
	if area.name == 'enemy_hitbox':
		var what_enemy_pos = area.owner.global_position
		enemy_position.emit(what_enemy_pos)
		
		var area_collision : CollisionShape2D = area.get_node('collision')
		area_collision.set_deferred('disabled', true)
		
		var which_enemy = area.owner.get_groups()
		player.take_damage(which_enemy[0])

	elif area.is_in_group('bullets'):
		var what_enemy_pos = area.global_position
		enemy_position.emit(what_enemy_pos)
		player.take_damage('bullets')
		
	
func choose_knockback(enemy_pos):

	# it was like Globals.knockback_vec = Vector2(250 , -100)
	
	if enemy_pos.x > player.global_position.x:
		Globals.knockback_vec.x = -abs(Globals.knockback_vec.x)
	else:
		Globals.knockback_vec.x = abs(Globals.knockback_vec.x)
	
