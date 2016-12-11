extends KinematicBody2D

export var speed = 400
export var jumpWidth = 64
var animationNode
var currentAnimation
var nextAnimation
var rayNode
var jumpEnabled
var facing

func _ready():
	set_process(true)
	animationNode = get_node("AnimatedSprite")
	rayNode = get_node("RayCast2D")
	jumpEnabled = true
	facing = Vector2(0,0)

func _process(delta):
	# movement
	var input = Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		facing = Vector2(-1,0)
		input -= Vector2(1,0)
		rayNode.set_rotd(270)
		nextAnimation = "idle_left"
	if Input.is_action_pressed("move_right"):
		facing = Vector2(1,0)
		input += Vector2(1,0)
		rayNode.set_rotd(90)
		nextAnimation = "idle_right"
	if Input.is_action_pressed("move_up"):
		facing = Vector2(0,-1)
		input -= Vector2(0,1)
		rayNode.set_rotd(180)
		nextAnimation = "idle_up"
	if Input.is_action_pressed("move_down"):
		facing = Vector2(0,1)
		input += Vector2(0,1)
		rayNode.set_rotd(0)
		nextAnimation = "idle_down"
	input = input.normalized()
	move(input * speed * delta)
	
	# jump
	
		
	if Input.is_action_pressed("jump_left_forwards"):
		if jumpEnabled:
			#var left = Vector2(facing.y, -facing.x)
			#print("facing:",facing,"left:",left)
			#move((facing + left) * jumpWidth)
			move(Vector2(-1,-1) * jumpWidth)
			jumpEnabled = false
		#nextAnimation = "idle_down"
	elif Input.is_action_pressed("jump_left_backwards"):
		if jumpEnabled:
			#var left = Vector2(facing.y, -facing.x)
			#print("facing:",facing,"left:",left)
			#move((-facing + left) * jumpWidth)
			move(Vector2(-1,1) * jumpWidth)
			jumpEnabled = false
		#nextAnimation = "idle_down"
	elif Input.is_action_pressed("jump_right_forwards"):
		if jumpEnabled:
			#var right = Vector2(-facing.y, facing.x)
			#print("facing:",facing,"right:",right)
			#move((facing + right) * jumpWidth)
			move(Vector2(1,-1) * jumpWidth)
			jumpEnabled = false
		#nextAnimation = "idle_down"
	elif Input.is_action_pressed("jump_right_backwards"):
		if jumpEnabled:
			#var right = Vector2(-facing.y, facing.x)
			#print("facing:",facing,"right:",right)
			#move((-facing + right) * jumpWidth)
			move(Vector2(1,1) * jumpWidth)
			jumpEnabled = false
		#nextAnimation = "idle_down"
	else:
		jumpEnabled = true
	# adjust animation
	if currentAnimation != nextAnimation:
		currentAnimation = nextAnimation
		animationNode.play(nextAnimation)
