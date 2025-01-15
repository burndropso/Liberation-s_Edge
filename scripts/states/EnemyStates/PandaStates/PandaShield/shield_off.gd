extends State

@export var enemy : CharacterBody2D
@onready var anim_shield = $'../../anim_shield'

func Enter():
	anim_shield.hide()

func Update(_delta):
	if enemy.should_turn_shield_on == true:
		Transitioned.emit(self, 'shield_on')
	
func Exit():
	enemy.should_turn_shield_on = false
