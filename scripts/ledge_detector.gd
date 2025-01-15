extends RayCast2D

func is_colliding_ledge(hit_a_ledge : bool):
	if is_colliding():
		var collider = get_collider()
		#print("colider = " + str(collider))
		if collider.is_in_group('ledges'):
			hit_a_ledge = true
	else:
		hit_a_ledge = false
	
	return hit_a_ledge
