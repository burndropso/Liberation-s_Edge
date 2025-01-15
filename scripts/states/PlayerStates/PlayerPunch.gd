extends State
class_name PlayerPunch

@export var player : CharacterBody2D
@onready var anim = $"../../anim"
@onready var anim_combat = $"../../anim_combat"

@onready var punch = $player_attack/punch
@onready var stab = $player_attack/stab

@onready var bullet_position = $bullet_position
@onready var shoot_cooldown = $shoot_cooldown

const BULLET_SCENE = preload("res://prefabs/bullet.tscn")
const SPEED = 350.0
const AIR_FRICTION := 0.5
var direction
 
func Enter():
	player.velocity.x = 0
	which_weapon_animation()

func Update(_delta):
	
	if Globals.weapon == Globals.WEAPONS.SWORD:
		await anim_combat.animation_finished
	else:
		await anim.animation_finished
	 
	
	if Input.get_axis('ui_left', 'ui_right') != 0:
		Transitioned.emit(self, 'run')
	else:	
		Transitioned.emit(self, 'idle')


func Physics_Update(_delta):
	if Globals.weapon == Globals.WEAPONS.GUN:
		if Input.is_action_pressed('LMB'):
			shoot_bullet()


func Exit():
	punch.set_deferred("disabled", true)
	stab.set_deferred("disabled", true)


func which_weapon_animation():
	match Globals.weapon:
		Globals.WEAPONS.MELEE:
			anim.play('punch')
			punch.set_deferred("disabled", false)
		Globals.WEAPONS.SWORD:
			anim_combat.play('stab')
		Globals.WEAPONS.GUN:
			anim.play('shoot_idle_shoot')	


func shoot_bullet():
	var bullet_instance = BULLET_SCENE.instantiate()
	
	if shoot_cooldown.is_stopped():
		
		bullet_instance.set_direction(Globals.player_facing_dir)
	
		# add_sibling is the same as get_parent().add_child(bullet_instance)
		get_parent().get_parent().add_sibling(bullet_instance)
	
		bullet_instance.global_position = bullet_position.global_position
		shoot_cooldown.start()
