extends CharacterBody2D

@export var speed = 400
@export var acceleration: float = 2000.0

func get_input():
	var input_direction = Input.get_vector("move_right", "move_left", "move_down", "move_up")
	velocity = input_direction * speed

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
