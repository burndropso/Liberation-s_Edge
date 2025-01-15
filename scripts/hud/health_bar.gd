extends ProgressBar

@export var fsm : Node2D
@onready var timer = $Timer
@onready var damage_bar = $DamageBar
@onready var health_regen_timer = $health_regen_timer

var health = 0 
#: set = _set_health


func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health

	if health < prev_health:
		timer.start()
		health_regen_timer.start()
	else:
		damage_bar.value = health

	if health <= 0:
		fsm.force_change_state('die')

func init_health(_health):
# setting both bars at full
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health


func _on_timer_timeout():
	damage_bar.value = health


func _on_health_regen_timer_timeout():
	if health == 0:
		return
	elif health < 100:
		Globals.player_health += 20
		_set_health(Globals.player_health)
		health_regen_timer.start()
