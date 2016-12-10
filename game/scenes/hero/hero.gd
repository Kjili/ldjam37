extends KinematicBody2D

export var speed = 400

func _ready():
	set_process(true)

func _process(delta):
	var input = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_pressed("move_up"):
		input.y -= 1
	if Input.is_action_pressed("move_down"):
		input.y += 1
	input = input.normalized() * speed * delta
	move(input)