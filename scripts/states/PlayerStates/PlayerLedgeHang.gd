extends State
class_name PlayerLedgeHang

@export var player : CharacterBody2D
@onready var anim = $"../../anim"

func Enter():
	player.velocity = Vector2(0,0)
	Globals.is_hanging = true
	anim.play('hang')
	
	player.set_collision_mask_value(2, false)
	player.set_collision_mask_value(3, false)	
	
	
func Update(_delta):
	if Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, 'ledge_climb')	


func Exit():
	Globals.is_hanging = false
