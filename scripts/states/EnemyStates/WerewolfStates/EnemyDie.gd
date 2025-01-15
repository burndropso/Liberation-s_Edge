extends State
class_name WerewolfDie

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var anim_combat = $"../../anim_combat"

func Enter():
	anim_combat.set_deferred("active", false)
	anim.play("die")
	enemy.velocity.x = 0
	#frameFreeze(0.1, 1)
	await anim.animation_finished
	owner.queue_free()	



func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await (get_tree().create_timer(duration * timeScale).timeout)
	Engine.time_scale = 1.0
