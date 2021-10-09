extends Node

enum DashFrame{
	NONE, START, END
}

#TODO: connect weapon information recording with actuall weapon system when ready
enum AttackFrame{
	NONE, MELEE_START,  MELEE_END, SHOOT_START, SHOOT_END
}

enum WeaponType{
	SHOOT, WALL
}

enum ActionType { NONE, SHOOT, DASH, MELEE }
