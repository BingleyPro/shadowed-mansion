extends CharacterBody2D

@export var speed: float = 100.0
@export var acceleration: float = 10.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Calculate the target velocity
	var target_velocity = speed * direction
	
	# Move towards the target velocity
	velocity.x = move_toward(velocity.x, target_velocity.x, acceleration * delta)
	velocity.y = move_toward(velocity.y, target_velocity.y, acceleration * delta)
	
	# Move and slide with the current velocity
	move_and_slide()
