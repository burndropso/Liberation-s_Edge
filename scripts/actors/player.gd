extends CharacterBody2D

@onready var remote_transform := $remote as RemoteTransform2D
@onready var health_bar = $HUD/HealthBar
@onready var anim_combat = $anim_combat
@onready var fsm = $FSM
@onready var anim = $anim

const SPEED = 300.0
const AIR_FRICTION := 0.95
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Globals.player = self
	health_bar.init_health(Globals.player_health)
	#print("joypads = " + str(Input.get_connected_joypads()))
	#print(str(Input.get_joy_guid(0)))

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor() and not Globals.is_hanging and not Globals.is_on_wall: 
		velocity.y += gravity * delta
	elif Globals.is_on_wall:
		var wall_slide_gravity = 50
		velocity.y = min(abs(velocity.y), wall_slide_gravity)


	move_and_slide()


func move_player():
	var direction = Input.get_axis('ui_left', 'ui_right')
	
	# ps controller
	if direction < 0: direction = floor(direction)  
	else: direction = ceil(direction)
		
	if direction:
		velocity.x = lerp(velocity.x, direction * SPEED, AIR_FRICTION)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction != 0:
		anim.scale.x = direction
		fsm.scale.x = direction
		Globals.player_facing_dir = direction


func take_damage(enemy : String):
	get_tree().current_scene.get_node('camera').apply_shake(30)
	
	var damage = Globals.enemies_base_damage[enemy]
	Globals.player_health -= damage
	health_bar._set_health(Globals.player_health)

	if Globals.player_health <= 0:
		fsm.force_change_state('die')
	else:
		anim_combat.stop() # temporary solution to solve bug
		fsm.force_change_state('hurt')

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
	
