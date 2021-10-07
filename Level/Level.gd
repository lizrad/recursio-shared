extends Spatial


func get_spawn_positions(player_number):
	var node_name = "Player" + str(player_number) + "Spawns"
	if has_node(node_name):
		return get_node(node_name).get_children()
	else:
		Logger.error("Tried to get spawn positions for invalid node " + node_name)
		return null
