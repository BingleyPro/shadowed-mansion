extends Node2D

var player_in_building = false
var player_in_entrance = false
var floor = 0 # ground floor

var tween

func _ready():
	_hide(self.get_node("Interior"))
	_show(self.get_node("Exterior"))
	self.get_node("CollisionShape2D").set_deferred("disabled", false)

func _on_fade_area_body_entered(body):
	if body.name == "Player":
		_hide(self.get_node("Interior"))
		_fade(self, 0.5)

func _on_fade_area_body_exited(body):
	if body.name == "Player":
		_unfade(self, 1)
		self.get_node("CollisionShape2D").set_deferred("disabled", false)

func _on_entrance_area_body_entered(body):
	if body.name == "Player" and player_in_building == false:
		player_in_building = true
		player_in_entrance = true
		_fade(self.get_node("Exterior"), 0)
		_show(self.get_node("Interior"))
		self.get_node("CollisionShape2D").set_deferred("disabled", true)

func _on_entrance_area_body_exited(body):
	player_in_entrance = false

func _fade(node, fadeTo):
	if _can_fade(node):
		tween = get_tree().create_tween()
		#node.modulate.a = 0.5
		tween.tween_property(node, "modulate", Color(1, 1, 1, fadeTo), 0.3).set_trans(Tween.TRANS_LINEAR)
		tween.play()
	else:
		for child in node.get_children():
			_fade(child, 0.5)

func _unfade(node, fadeTo):
	if _can_fade(node):
		tween = get_tree().create_tween()
		#node.modulate.a = 1
		tween.tween_property(node, "modulate", Color(1, 1, 1, fadeTo), 0.3).set_trans(Tween.TRANS_LINEAR)
		tween.play()
	else:
		for child in node.get_children():
			_unfade(child, 1)

func _can_fade(node):
	return "modulate" in node

func _hide(node):
	if _can_visiblity(node):
		node.visible = 0
	else:
		for child in node.get_children():
			_hide(child)

func _show(node):
	if _can_visiblity(node):
		node.visible = 1
	else:
		for child in node.get_children():
			_show(child)

func _can_visiblity(node):
	return "visible" in node


func _on_exit_area_body_entered(body):
	if body.name == "Player" and player_in_building == true and player_in_entrance == false:
		player_in_building = false
		_unfade(self.get_node("Exterior"), 1)
