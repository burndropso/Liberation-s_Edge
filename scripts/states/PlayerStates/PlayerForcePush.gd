extends State

@export var player : CharacterBody2D
@onready var anim = $"../../anim"
@onready var force_push_raycast = $force_push_raycast

const THROWING_FORCE = 300

func Enter():
	player.velocity.x = 0
	force_push_raycast.set_deferred('enabled', true)
	anim.play('force_push') # anim not created yet

func Update(_delta):
	await anim.animation_finished
	Transitioned.emit(self, 'idle')

func Physics_Update(_delta):
	
	var enemies_collide = []  # The colliding objects go here.
	while anim.frame > 3 and force_push_raycast.is_colliding():
		var enemy = force_push_raycast.get_collider() # get the next object that is colliding.
		enemies_collide.append(enemy)  # add it to the array.
		force_push_raycast.add_exception(enemy) # add to ray's exception. That way it could detect something being behind it.
		force_push_raycast.force_raycast_update() # update the ray's collision query.

	#after all is done, remove the objects from ray's exception.	
	for enemy in enemies_collide:
		force_push_raycast.remove_exception(enemy)

	# now we can push them
	apply_knockback(enemies_collide)

func Exit():
	force_push_raycast.set_deferred('enabled', false)

func apply_knockback(enemies):
	var distance = THROWING_FORCE
	
	# can be used later to do something like:
	# the closer the player is to the enemy, the farthest he can throw him
	# var distance = player.global_position.distance_to(enemy.global_position)
	
	for enemy in enemies:
		if Globals.player_facing_dir < 0:
			distance = -THROWING_FORCE
		print("enemy.velocity = " + str(distance))
		enemy.velocity = Vector2(distance, -300)
