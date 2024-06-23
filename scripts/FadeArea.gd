extends Area2D

var tween

func _on_body_entered(body):
	if body.name == "Player":
		var parent = get_parent()
		_fade(parent)

func _on_body_exited(body):
	if body.name == "Player":
		var parent = get_parent()
		_unfade(parent)
		
func _fade(node):
	if _can_fade(node):
		tween = get_tree().create_tween()
		#node.modulate.a = 0.5
		tween.tween_property(node, "modulate", Color(1, 1, 1, 0.5), 0.3).set_trans(Tween.TRANS_LINEAR)
		tween.play()
	else:
		for child in node.get_children():
			_fade(child)

func _unfade(node):
	if _can_fade(node):
		tween = get_tree().create_tween()
		#node.modulate.a = 1
		tween.tween_property(node, "modulate", Color(1, 1, 1, 1), 0.3).set_trans(Tween.TRANS_LINEAR)
		tween.play()
	else:
		for child in node.get_children():
			_unfade(child)

func _can_fade(node):
	return "modulate" in node
