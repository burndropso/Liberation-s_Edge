extends State

@export var enemy : CharacterBody2D
@onready var anim = $"../../anim"
@onready var anim_combat = $"../../anim_combat"
@onready var timer = $Timer

const FROZEN_TIME := 3

func Enter():
	timer.start()
	enemy.velocity = Vector2(0, 0)
	anim.pause()
	anim_combat.pause()
	var enemy_tween = create_tween()
	enemy.modulate = Color(0,0.5,1,1)
	enemy_tween.tween_property(enemy, 'modulate', Color(1,1,1,1), FROZEN_TIME)
	
func Update(_delta):
	if timer.is_stopped():
		Transitioned.emit(self, 'idle')
	
	
