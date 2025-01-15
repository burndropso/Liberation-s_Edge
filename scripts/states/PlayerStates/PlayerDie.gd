extends State

@export var player : CharacterBody2D
@onready var anim = $"../../anim"
@onready var health_bar = $"../../HUD/HealthBar"

func Enter():
	player.velocity.x = 0
	anim.play('die')
	

func Physics_Update(_delta):
	await anim.animation_finished
	
