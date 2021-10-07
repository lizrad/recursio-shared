extends Spatial


# Scene to add  to the capture points for logic
export var capture_point_scene: PackedScene


func _ready():
	if not capture_point_scene:
		Logger.error("No Capture Point Scene! Capture Points will not work")
		return
	else:
		for point in $CapturePoints.get_children():
			var new_scene = capture_point_scene.instance()
			new_scene.global_transform = point.global_transform
			add_child(new_scene)


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


func get_capture_points():
	return $CapturePoints.get_children()
