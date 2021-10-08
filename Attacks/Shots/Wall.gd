extends StaticBody


var placed_by_body
var _current_health := 5

func _init() -> void:
	Logger.info("_init action", "Wall")


func _ready():
	$KillGhostArea.connect("body_entered", self, "_hit_body")
	$KillGhostArea.connect("area_entered", self, "_hit_area")


func initialize(owning_player) -> void:
	initialize_visual(owning_player)
	# TODO: need to register wall in World/Level to be able to delete?
	#get_tree().get_root().get_node("World").register_wall(self)


func initialize_visual(owning_player) ->void:
	# TODO: define and use player color
	#$MeshInstance.material_override.albedo_color = Constants.character_colors[owning_player.id]
	$MeshInstance.material_override.albedo_color = Color.red


func _hit_body(body) ->void:
	if body is Ghost and body != placed_by_body:
		Logger.info("body hit -> TODO: kill enemy contact/ghost/robot", "Wall")
		#body.daie()

func _hit_area(area) ->void:
	_current_health -= 1
	if _current_health < 1:
		queue_free()
