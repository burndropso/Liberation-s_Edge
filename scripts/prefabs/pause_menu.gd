extends CanvasLayer

@onready var resume_btn = $menu_holder/HBoxContainer/resume_btn


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		visible = true
		get_tree().paused = true
		resume_btn.grab_focus()


func _on_resume_btn_pressed():
	get_tree().paused = false
	visible = false


func _on_quit_btn_pressed():
	get_tree().quit()
