extends Area2D

@onready var bullet_explosion = $bullet_explosion
@onready var anim = $anim

var bullet_speed := 300.0
var direction := 1

func _physics_process(delta):
	position.x += bullet_speed * direction * delta

 
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

# only used when player is the one who is shooting
# mudar a direçao da bala. Recebe a dir do script do player
func set_direction(dir : float):
	direction = sign(dir) # prevents -0.98 like in the panda script

	# if the bullet is going left
	if dir < 0:
		# changes the bullet sprite 
		$anim.set_flip_h(true)
	else:
		$anim.set_flip_h(false)	
		
	$anim.play('player_bullet')


func _on_area_entered(area):
	if area.name == 'hurtbox' or area.name == 'player_hurt_area':
		$anim.queue_free()
		$collision.queue_free()
		bullet_explosion.set_deferred('emitting', true)
