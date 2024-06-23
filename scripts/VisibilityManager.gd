extends Node2D

@onready var player = $Player

@onready var building = $Building

var floors = []

func _ready():
	for floor in building.get_children():
		if floor is Node2D:
			floors.append(floor)
			
func _process(delta):
	for floor in floors:
		if _is_player_on_floor(player, floor):
			floor.show()
		else:
			floor.hide()
			
func _is_player_on_floor(player, floor):
	# logic to check the floor the player is on
	return false
