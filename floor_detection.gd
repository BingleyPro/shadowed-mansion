extends Area2D

var player_on_floor = false;
var objects_to_show = []

func _ready():
	objects_to_show = get_parent().find_node("ObjectsToShow", true, false).get_children()
	

func _on_floor_area_entered(area):
	if area.name == "Player":
