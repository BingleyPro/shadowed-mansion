extends Node2D

func _process(delta):
	updateYSorting()
	
func updateYSorting():
	var player = self.get_parent().find_child("Player")
	var tilemap = self.get_parent().find_child("Building/Interior/Ground Floor/ObjectsToShow/Tilemap")
	
	var wallsLayer = tilemap.get_layer_named("Walls")
	
	var objectsToSort = []
	for x in range(tilemap.get_used_cells().x):
		for y in range(tilemap.get_used_cells().y):
			var tile = wallsLayer.get_cell_item(x, y)
			if tile != -1: # if tile does exist
				var tilePosition = tilemap.map_to_world(Vector2(x, y))
				objectsToSort.append({"node": tile, "position": tilePosition})
	
	# Sort objects by their Y position
	objectsToSort.sort_custom(self, "_sort_compare_y")
	
	for i in range(objectsToSort.size()):
		tilemap.remove_child(objectsToSort[i]["node"])
		tilemap.add_child(objectsToSort[i]["node"])
		
	if player.position.y < tilemap.position.y:
		player.z_index = tilemap.z_index -1
	else:
		player.z_index = tilemap.z_index + 1
		
func _sort_compare_y(a, b):
	return a["position"].y < b["position"].y ? -1 : 1
