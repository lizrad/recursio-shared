extends Spatial


func get_spawn_points(player_number):
	var node_name = "Player" + str(player_number) + "Spawns"
	if has_node(node_name):
		var spawn_positions = []
		for position in get_node(node_name).get_children():
			spawn_positions.append(position.global_transform.origin)
		
		return spawn_positions
	else:
		Logger.error("Tried to get spawn positions for invalid node " + node_name)
		return null
