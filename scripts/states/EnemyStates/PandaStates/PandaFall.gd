extends State

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"

func Enter():
	anim.play('fall')
	
func Physics_Update(_delta):
	if enemy.velocity.y == 0:
		Transitioned.emit(self, 'idle')
