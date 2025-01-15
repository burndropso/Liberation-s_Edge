extends State

@export var player : CharacterBody2D
@onready var anim = $"../../anim"
@onready var ledge_detector = $'../ledge_detector'

var hit_a_ledge = false

func Enter():
	anim.play('fall')

func Update(_delta):
	hit_a_ledge = ledge_detector.is_colliding_ledge(hit_a_ledge)
	
	if player.is_on_floor():
		Transitioned.emit(self, 'land')
	elif player.is_on_wall_only() and Globals.abilities['WALL_DRAG']:
		Transitioned.emit(self, 'wall_slide')
	elif Input.is_action_pressed('ui_accept'):
		Transitioned.emit(self, 'jump')
	elif hit_a_ledge:
		Transitioned.emit(self, 'ledge_hang')

func Physics_Update(_delta):
	player.move_player()
 
