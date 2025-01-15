extends CharacterBody2D
class_name EnemyBase

@onready var player = get_tree().current_scene.get_node('player')
@onready var anim = $anim
@onready var hurtbox = $hurtbox
@onready var fsm = $FSM

var current_health : int
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var enemy_dir : int = 1
var spotted_player : bool = false

func _ready():
	var which_enemy = self.get_groups()
	current_health = Globals.enemies_base_health[which_enemy[0]]
	

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor(): 
		velocity.y += gravity * delta 


	move_and_slide()

func check_dir():
	var dir_to_player = sign(global_position.direction_to(player.global_position))
	
	if (dir_to_player.x > 0 and enemy_dir < 0) or (dir_to_player.x < 0 and enemy_dir > 0):
		anim.scale.x *= -1
		hurtbox.scale.x *= -1
		fsm.scale.x *= -1
		enemy_dir *= -1

func take_damage(type_dmg : String):
	#get_tree().current_scene.get_node('camera').apply_shake(1)
	#print('who = ' + str(type_dmg) + ' current_health = ' + str(current_health) + ' damage = ' + str(Globals.player_base_damage[type_dmg]))
	
	current_health -= Globals.player_base_damage[type_dmg]
	
	if current_health <= 0:
		fsm.force_change_state('die')
	else:
		fsm.force_change_state('hurt')
 


func _on_spotted_player_body_entered(body):
	if body.name == 'player':
		spotted_player = true	
