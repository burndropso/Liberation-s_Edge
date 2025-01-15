extends State

@export var player : CharacterBody2D
@onready var anim: AnimatedSprite2D = owner.get_node('anim')
@onready var player_sfx = $'../../player_SFX'
@onready var respawn_marker : Marker2D = get_tree().current_scene.get_node('respawn')


func Enter():
	respawn_marker.global_position = player.global_position + Vector2(0, -50)
	player_sfx.play()
	anim.play('land')
	 
	
func Update(_delta):
	
	#SHOULD BE LIKE THIS AFTER MOJO
	#if Input.is_anything_pressed():
		#Transitioned.emit(self, 'idle')
	#else:
		#await anim.animation_finished
		#Transitioned.emit(self, 'idle')

	if Globals.weapon == Globals.WEAPONS.SWORD and Input.is_action_pressed('ui_defend'):
		Transitioned.emit(self, 'defend')
	elif Input.get_axis('ui_left', 'ui_right'):
		Transitioned.emit(self, 'run')
	elif Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		Transitioned.emit(self, 'jump')
	elif Input.is_action_just_pressed('LMB'):
		Transitioned.emit(self, 'attack')
	elif Input.is_action_pressed('ui_force_freeze') or (Input.is_joy_button_pressed( 0 ,JOY_BUTTON_LEFT_SHOULDER) and Input.is_joy_button_pressed( 0 ,JOY_BUTTON_RIGHT_SHOULDER)):
		Transitioned.emit(self, 'force_freeze')	
	elif Input.is_action_pressed('ui_force_pull') and not Input.is_joy_button_pressed( 0 ,JOY_BUTTON_RIGHT_SHOULDER):
		Transitioned.emit(self, 'force_pull')
	elif Input.is_action_pressed('ui_force_push') and not Input.is_joy_button_pressed( 0 ,JOY_BUTTON_LEFT_SHOULDER):
		Transitioned.emit(self, 'force_push')
	elif player.velocity.y != 0:
		Transitioned.emit(self, 'fall')
	else:
		await anim.animation_finished
		Transitioned.emit(self, 'idle')

	
