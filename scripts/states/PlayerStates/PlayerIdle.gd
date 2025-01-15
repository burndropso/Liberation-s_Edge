extends State
class_name PlayerIdle

@export var player : CharacterBody2D
@onready var anim = $"../../anim"

func Enter():
	player.velocity.x = 0

func Update(_delta):
	if Input.is_action_pressed('ui_defend') and Globals.weapon == Globals.WEAPONS.SWORD:
		Transitioned.emit(self, 'defend')
	elif Input.get_axis('ui_left', 'ui_right'):
		Transitioned.emit(self, 'run')
	elif Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		Transitioned.emit(self, 'jump')
	elif Input.is_action_just_pressed('LMB'):
		Transitioned.emit(self, 'attack')
	elif Input.is_action_pressed('ui_force_freeze') and Globals.abilities['FORCE_FREEZE']:
		Transitioned.emit(self, 'force_freeze')		
	#elif Input.is_action_pressed('ui_force_freeze') or (Input.is_joy_button_pressed( 0 ,JOY_BUTTON_LEFT_SHOULDER) and Input.is_joy_button_pressed( 0 ,JOY_BUTTON_RIGHT_SHOULDER)):
		#Transitioned.emit(self, 'force_freeze')	
	elif Input.is_action_pressed('ui_force_pull') and Globals.abilities['FORCE_PULL']:
		Transitioned.emit(self, 'force_pull')
	elif Input.is_action_pressed('ui_force_push') and Globals.abilities['FORCE_PUSH']:
		Transitioned.emit(self, 'force_push')
	elif player.velocity.y != 0:
		Transitioned.emit(self, 'fall')	
	 
	
	
func Physics_Update(_delta):
	which_weapon_animation()
	 
func which_weapon_animation():
	match Globals.weapon:
		Globals.WEAPONS.MELEE:
			anim.play('idle')
		Globals.WEAPONS.SWORD:
			anim.play('sword_idle')
		Globals.WEAPONS.GUN:
			anim.play('shoot_idle_test')
	
