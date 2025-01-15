extends CharacterBody2D

@onready var player = get_tree().current_scene.get_node('player')
@onready var anim = $anim
@onready var anim_shield = $anim_shield
@onready var hurtbox = $hurtbox
@onready var detect_bullet = $detect_bullet
@onready var fsm = $FSM
@onready var shield_fsm = $shield_FSM

var current_health : int

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var spotted_player : bool = false
var should_turn_shield_on : bool = false
var enemy_dir : int = 1
var areas: Array[Area2D]

func _ready():
	var which_enemy = self.get_groups()
	current_health = Globals.enemies_base_health[which_enemy[0]]


func _physics_process(delta):

	if not is_on_floor():  # Adding gravity
		velocity.y += gravity * delta 
 
	move_and_slide()


func _on_spotted_player_body_entered(body):
	if body.name == 'player':
		spotted_player = true

func check_dir():
	var dir_to_player =sign(global_position.direction_to(player.global_position))
	 
	if (dir_to_player.x > 0 and enemy_dir < 0) or (dir_to_player.x < 0 and enemy_dir > 0):
			
			enemy_dir *= -1
			
			anim.scale.x *= -1
			anim_shield.scale.x *= -1
			hurtbox.scale.x *= -1
			detect_bullet.scale.x *= -1
			fsm.scale.x *= -1
			shield_fsm.scale.x *= -1
			
func take_damage(type_dmg : String):
	#get_tree().current_scene.get_node('camera').apply_shake(1)
	#print('who = ' + str(type_dmg) + ' current_health = ' + str(current_health) + ' damage = ' + str(Globals.player_base_damage[type_dmg]))
	
	current_health -= Globals.player_base_damage[type_dmg]
	
	if current_health <= 0:
		fsm.force_change_state('die')
	else:
		fsm.force_change_state('hurt')

func _on_detect_bullet_area_entered(_area):
	areas = detect_bullet.get_overlapping_areas()
	for area in areas:
		if area.is_in_group('bullets'): 
			var bullet_anim : AnimatedSprite2D = area.get_node('anim')
			if bullet_anim.animation == 'player_bullet':
				should_turn_shield_on = true
		else:
			areas.remove_at(area.get_index()) # we only want player bullets in the array
