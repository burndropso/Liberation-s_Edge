extends ScrollContainer

@export var card_scale = 1 # (float, 0.5, 1, 0.1)
@export var card_current_scale = 1.3 # (float, 1, 1.5, 0.1)
@export var scroll_duration = 1.3 # (float, 0.1, 1, 0.1)

var card_current_index: int = 0
var card_y_positions: Array = []

@onready var scroll_tween: Tween 
@onready var margin_b: int = $CenterContainer/MarginContainer.get("theme_override_constants/margin_bottom")
@onready var card_space: int = $CenterContainer/MarginContainer/VBoxContainer.get("theme_override_constants/separation")
@onready var card_nodes: Array = $CenterContainer/MarginContainer/VBoxContainer.get_children()


func _ready() -> void:	
	get_h_scroll_bar().modulate.a = 0	
	call_deferred("_set_initial_positions")
		
	
func _set_initial_positions()->void:
	for _card in card_nodes:
		var _card_pos_y: float = (margin_b + _card.position.y) - ((size.y - _card.size.y) / 2)		
		_card.pivot_offset = (_card.size / 2)
		card_y_positions.append(_card_pos_y)
	scroll_horizontal = card_y_positions[card_current_index]
	scroll()

func _process(delta: float) -> void:
	for _index in range(card_y_positions.size()):
		var _card_pos_y: float = card_y_positions[_index]
		var _swipe_length: float = (card_nodes[_index].size.x / 2) + (card_space / 2)
		var _swipe_current_length: float = abs(_card_pos_y - scroll_vertical)
		var _card_scale: float = remap(_swipe_current_length, _swipe_length, 0, card_scale, card_current_scale)
		var _card_opacity: float = remap(_swipe_current_length, _swipe_length, 0, 0.3, 1)
		
		_card_scale = clamp(_card_scale, card_scale, card_current_scale)
		_card_opacity = clamp(_card_opacity, 0.3, 1)
		
		card_nodes[_index].scale = Vector2(_card_scale, _card_scale)
		card_nodes[_index].modulate.a = _card_opacity
		
		if _swipe_current_length < _swipe_length:
			card_current_index = _index


func scroll() -> void:	
	scroll_tween = create_tween().set_parallel(true)
	scroll_tween.tween_property(
		self,
		"scroll_vertical",
		card_y_positions[card_current_index],
		scroll_duration).from(scroll_vertical).set_trans(scroll_tween.TRANS_BACK).set_ease(scroll_tween.EASE_OUT)
	
	for _index in range(card_nodes.size()):
		var _card_scale: float = card_current_scale if _index == card_current_index else card_scale
		scroll_tween.tween_property(
			card_nodes[_index],
			"scale",
			Vector2(_card_scale,_card_scale),
			scroll_duration,).from(card_nodes[_index].scale).set_trans(scroll_tween.TRANS_QUAD).set_ease(scroll_tween.EASE_OUT)
			


func _on_ScrollContainer_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			scroll_tween.stop()
		else:
			scroll()
