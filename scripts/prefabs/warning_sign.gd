extends Node2D

@export var lines : Array[String]

@onready var texture = $texture
@onready var area_sign = $area_sign

var player_is_inside : bool = false

func _process(_delta):
	if player_is_inside:
		texture.show()
		if Input.is_action_pressed("interact") and not DialogManager.is_message_active:
			DialogManager.start_message(global_position, lines)
	elif not player_is_inside and DialogManager.dialog_box == null:
		texture.hide()

func _on_area_sign_body_entered(_body):
	player_is_inside = true

func _on_area_sign_body_exited(_body):
	player_is_inside = false
	if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()			
			DialogManager.is_message_active = false	
			DialogManager.current_line = 0
