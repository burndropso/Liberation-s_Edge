extends State

@export var player : CharacterBody2D
@export var anim : AnimatedSprite2D
@onready var force_freeze_raycast = $force_freeze_raycast


func Enter():
	player.velocity.x = 0
	force_freeze_raycast.set_deferred('enabled', true)
	anim.play('force_push') # anim not created yet

func Update(_delta):
	await anim.animation_finished
	Transitioned.emit(self, 'idle')

func Physics_Update(_delta):
	
	var enemies_collide = []  # The colliding objects go here.
	while anim.frame > 3 and force_freeze_raycast.is_colliding():
		var enemy = force_freeze_raycast.get_collider() # get the next object that is colliding.
		enemies_collide.append(enemy)  # add it to the array.
		force_freeze_raycast.add_exception(enemy) # add to ray's exception. That way it could detect something being behind it.
		force_freeze_raycast.force_raycast_update() # update the ray's collision query.

	#after all is done, remove the objects from ray's exception.	
	for enemy in enemies_collide:
		force_freeze_raycast.remove_exception(enemy)

	# now we can freeze them
	apply_freeze(enemies_collide)

func Exit():
	force_freeze_raycast.set_deferred('enabled', false)

func apply_freeze(enemies):
	for enemy : CharacterBody2D in enemies:
		var enemy_state_mach = enemy.get_node('FSM')
		enemy_state_mach.force_change_state('frozen')
	
