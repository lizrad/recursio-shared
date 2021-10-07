extends Node

var config


const NONE = 0

const DASH_START = 1
const DASH_END = 2

#TODO: connect weapon information recording with actuall weapon system when ready
const MELEE_START = 1
const WEAPON_START = 2
const MELEE_END = 3
const WEAPON_END = 4

const GUN = 0
const WALL = 1

enum ActionType { SHOOT, DASH, MELEE }

func _init():
	config = ConfigFile.new()
	var err = config.load("res://Shared/constants.ini")

	if err != OK:
		Logger.error("Could not load shared config file!")


func get_value(section, key, default = null):
	return config.get_value(section, key, default)
