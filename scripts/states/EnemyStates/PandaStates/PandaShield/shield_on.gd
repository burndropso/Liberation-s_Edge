extends State

@export var enemy : CharacterBody2D
@onready var anim_shield = $'../../anim_shield'
@onready var shield = $'../../shield'
@onready var timer = $'../Timer'

func Enter():
	timer.start()
	anim_shield.show()
	shield.set_deferred('disabled', false)
	anim_shield.play('activate_shield')
	await anim_shield.animation_finished
	anim_shield.play('shield_on')
	
	
func Update(_delta):
	#if timer.is_stopped() and not enemy.should_turn_shield_on: 
		#Transitioned.emit(self, 'shield_off')
	if timer.is_stopped() and enemy.areas.is_empty(): 
		Transitioned.emit(self, 'shield_off')	
	
func Exit():
	anim_shield.play('deactivate_shield')
	shield.set_deferred('disabled', true)
