extends State
class_name PlayerRoll

@export var player : CharacterBody2D
@onready var anim = $"../../anim"
@onready var collision = $"../../collision"
@onready var player_hurt_area = $'../../hurtbox/player_hurt_area'

const AIR_FRICTION = 0.5
const DASH_SPEED = 370
var direction


func Enter():
	player.set_collision_mask_value(3, false)
	player_hurt_area.set_collision_mask_value(4, false)
	player_hurt_area.set_collision_layer_value(6, false)
	direction = float(Globals.player_facing_dir)
	anim.play('roll')
	
func Update(_delta):	
	if Input.is_action_pressed("ui_accept") and player.is_on_floor():
		Transitioned.emit(self, 'jump')
		
	await anim.animation_finished
	if Input.get_axis('ui_left', 'ui_right'):
		Transitioned.emit(self, 'run')	
	else:
		Transitioned.emit(self, 'idle')	

func Physics_Update(_delta):
	if direction != 0:
		anim.scale.x = direction

	player.velocity.x = lerp(player.velocity.x, direction * DASH_SPEED, AIR_FRICTION)

func Exit():
	player.velocity.x = 0
	player.set_collision_mask_value(3, true)
	player_hurt_area.set_collision_mask_value(4, true)
	player_hurt_area.set_collision_layer_value(6, true)
