extends State
class_name PlayerDoubleJump

@export var player : CharacterBody2D
@onready var fsm = $".."
@onready var anim = $"../../anim"
@onready var ledge_detector = $'../ledge_detector'

const JUMP_VELOCITY = -450
var hit_a_ledge = false

func Enter():
	anim.play('double_jump')
	player.velocity.y = JUMP_VELOCITY

func Update(_delta):
	
	hit_a_ledge = ledge_detector.is_colliding_ledge(hit_a_ledge)
	
	if player.is_on_floor():
		Transitioned.emit(self, 'land')
	elif player.is_on_wall_only() and Globals.abilities['WALL_DRAG']:
		Transitioned.emit(self, 'wall_slide')
	elif hit_a_ledge:
		Transitioned.emit(self, 'ledge_hang')
	elif player.velocity.y > 0:
		Transitioned.emit(self, 'fall')

func Physics_Update(_delta):
	player.move_player()
