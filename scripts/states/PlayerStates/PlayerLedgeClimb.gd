extends State
class_name PlayerLedgeClimb

@export var player : CharacterBody2D
@onready var anim = $"../../anim"
@onready var jump = $'../jump'  # temp solution for the demo MOJO
@onready var double_jump = $'../double_jump'  # temp solution for the demo MOJO

var CLIMB_VELOCITY = Vector2(120, -165)

func Enter():
	anim.play('climb_ledge')
	

func Update(_delta):
	await anim.animation_finished
	Transitioned.emit(self, 'idle')

func Physics_Update(_delta):
	if anim.frame > 1:
		player.set_collision_mask_value(2, false)
		player.set_collision_mask_value(3, false)	
	player.velocity = CLIMB_VELOCITY
	if Globals.player_facing_dir < 0:
		player.velocity.x *= -1
		

func Exit():
	player.set_collision_mask_value(2, true)
	player.set_collision_mask_value(3, true)
	jump.hit_a_ledge = false  # temp solution for the demo MOJO
	double_jump.hit_a_ledge = false  # temp solution for the demo MOJO
	
