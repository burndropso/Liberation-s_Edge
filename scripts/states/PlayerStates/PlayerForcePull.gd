extends State

@export var player : CharacterBody2D
@onready var anim = $"../../anim"
@onready var force_pull_raycast = $force_pull_raycast
@onready var cooldown = $cooldown

func Enter():
	player.velocity.x = 0
	force_pull_raycast.set_deferred('enabled', true)
	anim.play('force_pull') # anim not created yet

func Update(_delta):
	await anim.animation_finished
	Transitioned.emit(self, 'idle')

func Physics_Update(_delta):
	var enemies_collide = []  # The colliding objects go here.
	while force_pull_raycast.is_colliding():
		var enemy = force_pull_raycast.get_collider() # get the next object that is colliding.
		enemies_collide.append(enemy)  # add it to the array.
		force_pull_raycast.add_exception(enemy) # add to ray's exception. That way it could detect something being behind it.
		force_pull_raycast.force_raycast_update() # update the ray's collision query.

	#after all is done, remove the objects from ray's exception.	
	for enemy in enemies_collide:
		force_pull_raycast.remove_exception(enemy)

	# now we can push them
	apply_knockback(enemies_collide)

func Exit():
	force_pull_raycast.set_deferred('enabled', false)

func apply_knockback(enemies):
	 
	for enemy in enemies:
		
		# -50 so the enemy doesn't land on player's top and yes on his front
		var distance = abs(player.global_position.distance_to(enemy.global_position) - 50)

		if Globals.player_facing_dir > 0:
			distance *= -1

		enemy.velocity = Vector2(distance, -400)
