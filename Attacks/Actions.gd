extends Node

var _shot_scene = preload("res://Shared/Attacks/Shots/HitscanShot.tscn")
var _wall_scene = preload("res://Shared/Attacks/Shots/Wall.tscn")
var _melee_scene = preload("res://Shared/Attacks/Melee/Melee.tscn")

# preconfigured actions
# Action(ammo, cd, recharge, activation_max, action_scene)
# TODO: - unify ms/s input params
var shot = Action.new("hitscan", 10, 0.5, -1, 0, _shot_scene)
var wall = Action.new("wall", 3, 0.5, -1, 0, _wall_scene)
var dash = Action.new("dash", 2, 0.5, 5, 500, null)
var melee = Action.new("melee", -1, 0.5, -1, 0, _melee_scene)
var all_actions = [ shot, wall, melee, dash ]
	
# TODO: add selected weapon type per configuration ingame
onready var types_to_actions = { 
	Enums.ActionType.SHOOT: shot, 
	Enums.ActionType.MELEE: melee, 
	Enums.ActionType.DASH: dash,
	Enums.ActionType.WALL: wall
}
