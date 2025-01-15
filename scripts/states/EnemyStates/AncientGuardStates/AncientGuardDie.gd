extends State

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var enemy_hitbox = $'../shoot/enemy_hitbox'


func Enter():
	enemy_hitbox.queue_free() # force_change_state causes bug
	enemy.set_collision_layer_value(3, false)  # so the player can pass through when enemy is dying
	anim.play('die')
	enemy.velocity.x = 0
	
	get_tree().current_scene.get_node('camera').apply_shake(15)
	#frameFreeze(0.1, 1)
	
	await anim.animation_finished
	await get_tree().create_timer(2).timeout
	owner.queue_free()	



func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await (get_tree().create_timer(duration * timeScale).timeout)
	Engine.time_scale = 1.0
