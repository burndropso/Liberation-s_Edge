extends Node

#@onready var ui_weapon_selector = get_tree().current_scene.get_node('UI').get_node('ui_weapon_selector')
var cursor = load('res://assets/pointer_c_shaded.svg')
var player = null  # on player's _on_ready func there is Globals.player = self

var player_health := 100
var player_life := 3

var skill_points := 1

var player_start_position = null
var current_checkpoint = null


var is_on_wall : bool = false
var is_hanging : bool = false
var player_facing_dir : int = 1

var knockback_vec := Vector2(250, -100) # default knockback value

var weapon # current weapon being used
enum WEAPONS {MELEE, SWORD, GUN}

var abilities : Dictionary = {
	'DOUBLE_JUMP': false,
	'ROLL': true,
	'WALL_DRAG': false,
	'MELEE': true,
	'SWORD': false,
	'PARRY': false,
	'GUN': false,
	'FORCE_PULL': false,
	'FORCE_PUSH': false,
	'FORCE_FREEZE': false,
	'FASTER_REGEN': false,
	'MAX_HEALTH_BOOST': false,
	'BULLET_DEFLECTION': false,
	
	
	#GOD MODE
	#'DOUBLE_JUMP': true,
	#'ROLL': true,
	#'WALL_DRAG': true,
	#'MELEE': true,
	#'SWORD': true,
	#'PARRY': true,
	#'GUN': true,
	#'FORCE_PULL': true,
	#'FORCE_PUSH': true,
	#'FORCE_FREEZE': true,
	#'FASTER_REGEN': true,
	#'MAX_HEALTH_BOOST': true,
	#'BULLET_DEFLECTION': true,
}

var player_base_damage : Dictionary = {
	'MELEE': 25,
	'SWORD': 40,
	'GUN': 20,
}

var enemies_base_health : Dictionary = {
	'enemies': 100,
	'panda': 200,
	'ancient_guard': 50,
}

var enemies_base_damage : Dictionary = {
	'enemies': 25,
	'panda': 40,
	'ancient_guard': 20,
	'bullets': 10,
}


func _ready():
	Input.set_custom_mouse_cursor(cursor)
	weapon = WEAPONS.MELEE


func _process(_delta):
	
	# iterate over vertical wheel's weapon selector
	if Input.is_action_just_pressed("change_weapon_up"): 
		weapon = (weapon + 1 ) % WEAPONS.size()
		var weapon_key = WEAPONS.find_key(weapon)
		 
		
		# if weapon is locked it will rotate to the next unlocked one
		while not abilities[weapon_key]:  
			weapon = (weapon + 1 ) % WEAPONS.size()
			weapon_key = WEAPONS.find_key(weapon)
		
		
	elif Input.is_action_just_pressed("change_weapon_down"):
		weapon = abs((-weapon - 1 ) % WEAPONS.size())
		var weapon_key = WEAPONS.find_key(weapon)
		 
		
		while not abilities[weapon_key]:  
			weapon = abs((-weapon - 1 ) % WEAPONS.size())
			weapon_key = WEAPONS.find_key(weapon)
			 

		 
		
		
func respawn_player():
	#var player : CharacterBody2D = get_tree().current_scene.get_node('player')
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
	else:
		player.global_position = player_start_position.global_position	
