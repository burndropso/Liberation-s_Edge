extends State

@export var enemy : CharacterBody2D
@onready var anim = $'../../anim'
@onready var bullet_position = $bullet_position
@onready var player = get_tree().current_scene.get_node('player')
@onready var shoot_raycast = $'../idle/shoot_raycast'

const BULLET_SCENE = preload("res://prefabs/bullet.tscn")
var dir_to_player = 1
var shooted: bool = false

func Enter():
	enemy.velocity.x = 0
	await enemy.check_dir()
	anim.play('shoot')

func Update(_delta):
	await anim.animation_finished
	Transitioned.emit(self, 'idle')

func Physics_Update(_delta):
	
	if anim.frame == 3 and not shooted:
		shoot_bullet()


func shoot_bullet():
	var bullet_instance = BULLET_SCENE.instantiate()
	var bullet_dir = enemy.global_position.direction_to(player.global_position)
	var bullet_anim = bullet_instance.get_node('anim')
	
	bullet_instance.set_collision_layer_value(3, false)
	bullet_instance.set_direction(bullet_dir.x)
	bullet_anim.scale *= Vector2(2, 2)
	bullet_anim.play('panda_bullet')
	# add_sibling is the same as get_parent().add_child(bullet_instance)
	owner.add_sibling(bullet_instance)
	
	bullet_instance.global_position = bullet_position.global_position
	shooted = true

func Exit():
	shooted = false
