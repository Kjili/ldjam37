extends KinematicBody2D

export var speed = 400
var animationNode
var currentAnimation
var nextAnimation

func _ready():
	set_process(true)
	animationNode = get_node("AnimatedSprite")

func _process(delta):
	var input = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		input.x -= 1
		nextAnimation = "idle_left"
	if Input.is_action_pressed("move_right"):
		input.x += 1
		nextAnimation = "idle_right"
	if Input.is_action_pressed("move_up"):
		input.y -= 1
		nextAnimation = "idle_up"
	if Input.is_action_pressed("move_down"):
		input.y += 1
		nextAnimation = "idle_down"
	input = input.normalized() * speed * delta
	move(input)
	
	if currentAnimation != nextAnimation:
		currentAnimation = nextAnimation
		animationNode.play(nextAnimation)
