extends State
class_name PlayerDefend

@export var player : CharacterBody2D
@onready var fsm = $".."
@onready var block_collision = $block/collision
@onready var anim = $"../../anim"
@onready var parry_timer = $parry_timer
@onready var parry_collision = $parry/collision
@onready var collision = $"../../hurtbox/player_hurt_area/collision"


func Enter():
	player.velocity.x = 0
	collision.set_deferred("disabled", true)
	block_collision.set_deferred("disabled", false)
	parry_collision.set_deferred("disabled", false)
	anim.play('defend')
	parry_timer.start()


func Update(_delta):
	if Input.is_action_just_released('ui_defend'):
		Transitioned.emit(self, 'idle')

func Physics_Update(_delta):
	var direction = Input.get_axis('ui_left', 'ui_right')
	
	if direction < 0: direction = floor(direction)  
	else: direction = ceil(direction)
	
	if parry_timer.is_stopped():
		parry_collision.set_deferred("disabled", true)
	
	if direction != 0:
		anim.scale.x = direction
		fsm.scale.x = direction	
		Globals.player_facing_dir = direction


func Exit():
	block_collision.set_deferred("disabled", true)
	parry_collision.set_deferred("disabled", true)
	collision.set_deferred("disabled", false)
	


func _on_parry_area_entered(area : Area2D):

	if area.name == 'enemy_hitbox':
		var enemy_pos = area.owner.global_position
		
		get_tree().current_scene.get_node('camera').apply_shake(30)
		
		# if player is facing backwards towards the enemy that just attacked him
		if (enemy_pos > player.global_position and Globals.player_facing_dir < 0) or (enemy_pos < player.global_position and Globals.player_facing_dir > 0):
			area.get_parent().is_player_facing_me(false)
			var which_enemy = area.owner.get_groups()
			player.take_damage(which_enemy[0])
		else:
			area.get_parent().is_player_facing_me(true) #enemy attack state node
			owner.get_node('HUD').flash()
	elif area.is_in_group('bullets'):
		area.direction *= -1
		area.scale.x *= -1
		area.set_collision_layer_value(3, true)
		get_tree().current_scene.get_node('camera').apply_shake(30)
		Input.start_joy_vibration(0,1,1,0.2)
		owner.get_node('HUD').flash()



func _on_block_area_entered(area):
	
	if area.name == 'enemy_hitbox':
		var enemy_pos = area.owner.global_position
		
		# if player is facing backwards towards the enemy that just attacked him
		if (enemy_pos > player.global_position and Globals.player_facing_dir < 0) or (enemy_pos < player.global_position and Globals.player_facing_dir > 0):
			area.get_parent().is_player_facing_me(false)
			player.take_damage()
		else:
			area.get_parent().is_player_facing_me(true)
	
