extends State

@export var player : CharacterBody2D
@onready var anim = $'../../anim'
@onready var ledge_detector = $'../ledge_detector'

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hit_a_ledge : bool = false

func Enter():
	Globals.is_on_wall = true
	anim.play('wall_slide')

func Update(_delta):
	
	
	if player.is_on_floor():
		Transitioned.emit(self, 'idle')	
	elif Input.is_action_just_pressed('ui_accept'):
		Transitioned.emit(self, 'jump')
	elif hit_a_ledge:
		Transitioned.emit(self, 'ledge_hang')

	hit_a_ledge = ledge_detector.is_colliding_ledge(hit_a_ledge)

func Exit():
	Globals.is_on_wall = false
	
