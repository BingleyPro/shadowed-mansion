extends Area2D

var player_on_floor = false

var exterior_node = null

func _ready():
	# Find the 'Exterior' node once during initialization
	exterior_node = get_parent().find_node("Exterior")
	if exterior_node == null:
		print("Exterior node not found")

func _show_objects():
	for child in self.get_children():
		child.visible = true
	if exterior_node:
		exterior_node.visible = false

func _hide_objects():
	for child in self.get_children():
		child.visible = false
	if exterior_node:
		exterior_node.visible = true

func _on_body_entered(body):
	if body.name == "Player":
		player_on_floor = true
		_show_objects()

func _on_body_exited(body):
	if body.name == "Player":
		player_on_floor = false
		_hide_objects()
