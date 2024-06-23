extends CharacterBody2D

@export var speed = 250
@export var acceleration: float = 200

enum {IDLE, WALK}
var state = IDLE

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/Idle/idle_bs2d/blend_position",
	"parameters/Walk/walk_bs2d/blend_position"
]

var animTree_state_keys = [
	"Idle",
	"Walk"
]

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_direction == Vector2.ZERO:
		state = IDLE
	else:
		state = WALK
		blend_position = input_direction
	
	velocity = input_direction * speed

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	animate()

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)
