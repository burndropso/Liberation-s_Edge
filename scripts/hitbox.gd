extends Area2D

@export var enemy_anim : AnimatedSprite2D


func _on_area_entered(area):
	if area.name == 'player_attack':
		enemy_anim.play('die')
		#frameFreeze(0.1, 1)
		await enemy_anim.animation_finished
		owner.queue_free()	


func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await (get_tree().create_timer(duration * timeScale).timeout)
	Engine.time_scale = 1.0
	
