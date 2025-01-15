extends CanvasLayer

@onready var skill_tree = $SkillTree


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	skill_tree.visible = false


func _unhandled_input(event):
	if event.is_action_pressed('ui_ability_menu'):
		if skill_tree.visible:
			skill_tree.hide()
			get_tree().paused = false
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
		else:	
			skill_tree.show()
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			Input.warp_mouse(Vector2(get_viewport().size * 0.5))
