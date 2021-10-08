extends Area

# TODO: combine attack common values
export var only_hit_one_body := true
var _damage := 10.0
var _bounce_strength := 250.0
var _attack_range := 1
var _attack_time := 0.1
var _owning_player
var _hit_something = false
var _continuously_damaging := false
var _damage_invincibility_time := 0
var _hit_bodies_invincibilty_tracker = {}

func initialize_visual() -> void:
	#_attack_time = attack_type.attack_time
	
	# TODO: could setup shape statically because does not change
	var sphereShape = SphereShape.new()
	sphereShape.radius = _attack_range
	$CollisionShape.shape = sphereShape
	$Visualization.scale = Vector3(_attack_range, _attack_range, _attack_range)
	# TODO: define and use player color
	#$Visualization.get_surface_material(0).albedo_color = Constants.character_colors[owning_player.id]
	$Visualization.get_surface_material(0).albedo_color = Color.red

#func initialize(owning_player, attack_type) ->void:
func initialize(owning_player) -> void:
	#_damage = attack_type.damage
	#_bounce_strength = attack_type.bounce_strength
	#_continuously_damaging = attack_type.continuously_damaging
	#_damage_invincibility_time = attack_type.damage_invincibility_time
	_owning_player = owning_player
	initialize_visual()

func _process(delta):
	_attack_time -= delta
	if _attack_time <= 0:
		queue_free()
		return

	for i in _hit_bodies_invincibilty_tracker:
		_hit_bodies_invincibilty_tracker[i]-=delta
		_hit_bodies_invincibilty_tracker[i] = clamp(_hit_bodies_invincibilty_tracker[i],0,_damage_invincibility_time)

func _hit_body(body) ->void:
	if body.is_in_group("Damagable"):
			assert(body.has_method("receive_hit"))
			if (not _hit_bodies_invincibilty_tracker.has(body) or _hit_bodies_invincibilty_tracker[body] <=0):
				_hit_bodies_invincibilty_tracker[body]=_damage_invincibility_time
				print(str("Melee attack hit body named ",body.name))
				_hit_something = true
				#body.receive_hit(AttackType.AttackTypeType.NORMAL, _damage, (body.global_transform.origin-global_transform.origin).normalized()*_bounce_strength)

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	if bodies.size() == 0:
		return
	if not _continuously_damaging:
		if _hit_something:
			return
		var nearest_body
		var nearest_distance = INF
		for body in bodies:
			if _hit_something:
				return
			if not body.is_in_group("Damagable"):
				continue
			if body == _owning_player:
				continue
			var distance = global_transform.origin.distance_to(body.global_transform.origin)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_body = body
		if nearest_body == null:
			return
		_hit_body(nearest_body)
	else:
		var other_player
		print("hit bodies size "+str(bodies.size()))
		for body in bodies:
			if not body.is_in_group("Damagable"):
				continue
			if body == _owning_player:
				continue
			print("hit "+body.name)
			# make sure we hit other player last
			if body.is_player():
				print ("found other player")
				other_player = body
				continue
			_hit_body(body)
		if other_player:
			print ("hit other player")
			_hit_body(other_player)
