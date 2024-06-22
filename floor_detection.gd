extends Area2D

var player_on_floor = false;
var objects_to_show = []

func _ready():
	objects_to_show = get_parent().find_node("ObjectsToShow", true, false).get_children()

func _on_floor_area_entered(area):
	if area.name == "Player":
		player_on_floor = true
		_show_objects()
		
func _on_floor_area_exited(area):
	if area.name == "Player":
		player_on_floor = false;
		_hide_objects()
		
func _show_objects():
	for obj in objects_to_show:
		obj.visible = true

func _hide_objects():
	for obj in objects_to_show:
		obj.visible = false
