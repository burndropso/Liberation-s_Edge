extends TextureButton
class_name SkillNode

@export var skill_name : String
@export var hover_msg : String
@export var is_root_node : bool
@export var skill_icon : CompressedTexture2D

@onready var panel = $Panel
@onready var label = $MarginContainer/Label
@onready var line_2d = $Line2D
@onready var hover_description = owner.get_node('hover_description') as RichTextLabel

signal activate

var DESCRIPTION_OFFSET = Vector2(75, -50)

var level : int = 0:
	set(value):
		level = value
		label.text = str(level) + "/3"

func set_skill_icon():
	if skill_icon != null:
		self.texture_normal = skill_icon

func _ready():
	set_skill_icon()
	activate.connect(_on_pressed)
	
	# connecting the lines and if the skill is already enabled lighting it up in a green color
	if get_parent() is SkillNode:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)

	# enable 1st skill of that branch or if skill is already unlocked 
	if is_root_node or (skill_name != '' and Globals.abilities[skill_name]):
		Globals.skill_points += 1  #increment to be decremented +1 -1 = 0
		emit_signal('activate')

func _on_pressed():
	if Globals.skill_points > 0 and level == 0:
		Globals.skill_points -= 1
		level = min(level+1, 3)
		panel.show_behind_parent = true

		line_2d.default_color = Color(0, 0.8, 0.1)
		
		var skills = get_children()
		for skill in skills:
			if skill is SkillNode :   # original --->  and level == 1 
				skill.disabled = false
		
		for ability in Globals.abilities:
			if ability == skill_name.to_upper():
				if Globals.abilities[ability] != true:
					Globals.abilities[ability] = true


# DESCRIPTION TEXTS------------------------------------------------------------
func _on_mouse_entered():
	resizeDumbNode()

	var mouse_pos = get_global_mouse_position()
	
	if mouse_pos.x > 720: DESCRIPTION_OFFSET.x = -hover_description.size.x
	else: DESCRIPTION_OFFSET.x = 70
	
	if mouse_pos.y > 200: DESCRIPTION_OFFSET.y = -hover_description.size.y
	else: DESCRIPTION_OFFSET.y = 50

	hover_description.global_position = global_position + DESCRIPTION_OFFSET
	
	hover_description.append_text(hover_msg)
	hover_description.show()

func _on_mouse_exited():
	hover_description.hide()
	hover_description.clear()
	hover_description.text = ""

func resizeDumbNode():
	hover_description.size.y = hover_msg.length() * 0.5
	hover_description.size.x = hover_msg.length() 
# -----------------------------------------------------------------------------
