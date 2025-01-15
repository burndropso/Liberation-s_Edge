extends Control

@onready var start_btn = $MarginContainer/HBoxContainer/VBoxContainer/start_btn
@onready var multiplayer_btn = $MarginContainer/HBoxContainer/VBoxContainer/multiplayer_btn
@onready var options_btn = $MarginContainer/HBoxContainer/VBoxContainer/options_btn
@onready var quit_btn = $MarginContainer/HBoxContainer/VBoxContainer/quit_btn

# Called when the node enters the scene tree for the first time.
func _ready():
	start_btn.pressed.connect(handle_menu_press.bind(start_btn))
	multiplayer_btn.pressed.connect(handle_menu_press.bind(multiplayer_btn))
	options_btn.pressed.connect(handle_menu_press.bind(options_btn))
	quit_btn.pressed.connect(handle_menu_press.bind(quit_btn))

func handle_menu_press(button_pressed):
	match button_pressed:
		start_btn:
			start_game()
		multiplayer_btn:
			start_multiplayer_game()
		options_btn:
			start_options()
		quit_btn:
			quit_game()

func start_game():
	get_tree().change_scene_to_file("res://levels/world_1.tscn")

func start_multiplayer_game():
	pass

func start_options():
	pass

func quit_game():
	pass
			
