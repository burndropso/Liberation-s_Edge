extends RichTextLabel

var current_points

func _process(_delta):
	
	if Input.is_action_just_pressed('batota'):
		Globals.skill_points += 1
	
	
	
	if Globals.skill_points != current_points:
		current_points = Globals.skill_points
		set_skill_points_available(Globals.skill_points)

func set_skill_points_available(points: int):
	clear()
	append_text('Skill Points : ')
	append_text(str(points))
