extends MarginContainer

@export var top_weapon : TextureRect
@export var middle_weapon : TextureRect
@export var bottom_weapon : TextureRect

@onready var v_box_container = $VBoxContainer
 
var scroll_duration = 0.2

func _ready():
	top_weapon.set_deferred('pivot_offset', top_weapon.size / 2) # to scale from the middle
	middle_weapon.set_deferred('pivot_offset', middle_weapon.size / 2) # to scale from the middle
	bottom_weapon.set_deferred('pivot_offset', bottom_weapon.size / 2) # to scale from the middle

	top_weapon.self_modulate = Color(1, 1, 1, 0.5)
	bottom_weapon.self_modulate = Color(1, 1, 1, 0.5)

	var tween : Tween = create_tween() #.set_parallel(true)
	tween.tween_property(middle_weapon, 'scale', Vector2(1.7, 1.7), scroll_duration).set_ease(tween.EASE_OUT)


func _physics_process(_delta):
	
	while not Globals.WEAPONS.find_key(Globals.weapon) == middle_weapon.weapon_name:
		scroll('down') 



func scroll(up_or_down : String):
	top_weapon = v_box_container.get_child(0)
	middle_weapon = v_box_container.get_child(1)
	bottom_weapon = v_box_container.get_child(2)
	
	decide_up_or_down(up_or_down)
	
	middle_weapon.set_deferred('z_index', 0)
	middle_weapon = v_box_container.get_child(1) # the new one in the middle
	middle_weapon.set_deferred('z_index', 1)
	
	top_weapon.self_modulate = Color(1, 1, 1, 0.5)
	bottom_weapon = v_box_container.get_child(2)  # temp solving logic issue
	bottom_weapon.self_modulate = Color(1, 1, 1, 0.5)
	middle_weapon.self_modulate = Color(1, 1, 1, 1)
	
	await get_tree().create_timer(0.2).timeout
	
	var tween : Tween = create_tween() #.set_parallel(true)
	tween.tween_property(middle_weapon, 'scale', Vector2(1.7, 1.7), scroll_duration).set_ease(tween.EASE_OUT)
	
	await get_tree().create_timer(0.2).timeout
	
# exchange the children's order 	
func decide_up_or_down(up_or_down : String ):
	if up_or_down.to_lower() == 'up':
		v_box_container.move_child(top_weapon, 2)
		v_box_container.move_child(middle_weapon, 0)
		v_box_container.move_child(bottom_weapon, 1)
	elif up_or_down.to_lower() == 'down':
		v_box_container.move_child(top_weapon, 1)
		v_box_container.move_child(middle_weapon, 2)
		v_box_container.move_child(bottom_weapon, 0)
	else:
		print('Error: up_or_down is not up neither down')
	
