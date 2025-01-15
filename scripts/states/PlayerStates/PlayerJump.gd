extends State
class_name PlayerJump

@export var player : CharacterBody2D

@onready var anim = $"../../anim"
@onready var ledge_detector = $'../ledge_detector'

const JUMP_VELOCITY = -400
var hit_a_ledge = false

func Enter():
	anim.play('jump')
	player.velocity.y = JUMP_VELOCITY    
 
func Update(_delta):
	hit_a_ledge = ledge_detector.is_colliding_ledge(hit_a_ledge)
	
	if player.is_on_floor():
		Transitioned.emit(self, 'land')
	elif Input.is_action_just_pressed("ui_accept") and !player.is_on_floor() and Globals.abilities['DOUBLE_JUMP']:
		Transitioned.emit(self, 'double_jump')
	elif hit_a_ledge:
		Transitioned.emit(self, 'ledge_hang')
	elif player.velocity.y > 0:
		Transitioned.emit(self, 'fall')

func Physics_Update(_delta):
	player.move_player()
