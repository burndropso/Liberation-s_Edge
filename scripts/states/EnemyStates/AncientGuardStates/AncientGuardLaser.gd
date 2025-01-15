extends State

@export var enemy : CharacterBody2D
@onready var anim = $'../../anim'
@onready var collision = $enemy_hitbox/collision
@onready var shoot_delay = $shoot_delay

var shooted: bool = false

func Enter():
	shoot_delay.start()
	await enemy.check_dir()
	

func Update(_delta):
	await anim.animation_finished
	Transitioned.emit(self, 'idle')

func Physics_Update(_delta):
	if shoot_delay.is_stopped():
		anim.play('laser')
		
		if anim.frame == 7 and not shooted:
			collision.set_deferred('disabled', false)

func Exit():
	shooted = false
	collision.set_deferred('disabled', true)
	shoot_delay.stop()
