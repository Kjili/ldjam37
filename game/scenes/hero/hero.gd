extends KinematicBody2D

var animationNode
var currentAnimation
var nextAnimation
var rayNode
var jumpEnabled
var facing
var neighbours
var standardDistance
var distance
var animationPlayer

func _ready():
	set_process_input(true)
	set_process(true)
	animationNode = get_node("AnimatedSprite")
	animationPlayer = get_node("AnimationPlayer")
	facing = "up"
	neighbours = { "up": { "left" : "right",  "right": "left" }, "right": { "left" : "down", "right": "up" }, "down": { "left" : "left", "right": "right" }, "left": { "left" : "up", "right": "down" } }
	standardDistance = get_global_pos().distance_to(get_parent().get_node("Enemy").get_pos())
	distance = standardDistance

func getPosition(facing, fixpoint, distance):
	if facing == "up":
		return Vector2(fixpoint.x, fixpoint.y + distance)
	if facing == "down":
		return Vector2(fixpoint.x, fixpoint.y - distance)
	if facing == "right":
		return Vector2(fixpoint.x - distance, fixpoint.y)
	if facing == "left":
		return Vector2(fixpoint.x + distance, fixpoint.y)
	return get_global_pos()

func _input(event):
	
	var newPos = get_global_pos()
	var fixpoint = get_parent().get_node("Enemy").get_pos()
	var distance = get_global_pos().distance_to(get_parent().get_node("Enemy").get_pos())
	
	# circular movements
	if event.is_action_pressed("move_left") and not event.is_echo():
		facing = neighbours[facing]["left"]
		nextAnimation = "idle_" + facing
		newPos = getPosition(facing, fixpoint, distance)
	if event.is_action_pressed("move_right") and not event.is_echo():
		facing = neighbours[facing]["right"]
		nextAnimation = "idle_" + facing
		newPos = getPosition(facing, fixpoint, distance)
	if event.is_action_pressed("move_up") and not event.is_echo() and distance > 0.5 * standardDistance + 2:
		distance -= 0.5 * standardDistance;
		newPos = getPosition(facing, fixpoint, distance)
	if event.is_action_pressed("move_down") and not event.is_echo() and distance < 1.5 * standardDistance - 2:
		distance += 0.5 * standardDistance;
		newPos = getPosition(facing, fixpoint, distance)
		
	set_global_pos(newPos)
	
	# dodging
	# TODO change position correctly
	if event.is_action_pressed("dodge_left"):
		if facing == "left":
			nextAnimation = "idle_" + neighbours[facing]["left"] + "_" + facing
			set_global_pos(Vector2(get_global_pos().x - 0.5 * distance, get_global_pos().y + 0.5 * distance))
		elif facing == "right":
			nextAnimation = "idle_" + neighbours[facing]["left"] + "_" + facing
			set_global_pos(Vector2(get_global_pos().x + 0.5 * distance, get_global_pos().y - 0.5 * distance))
		else:
			nextAnimation = "idle_" + facing + "_" + neighbours[facing]["left"]
			if facing == "up":
				set_global_pos(Vector2(get_global_pos().x - 0.5 * distance, get_global_pos().y - 0.5 * distance))
			else:
				set_global_pos(Vector2(get_global_pos().x - 0.5 * distance, get_global_pos().y + 0.5 * distance))
	if event.is_action_pressed("dodge_right"):
		if facing == "left":
			nextAnimation = "idle_" + neighbours[facing]["right"] + "_" + facing
			set_global_pos(Vector2(get_global_pos().x - 0.5 * distance, get_global_pos().y - 0.5 * distance))
		elif facing == "right":
			nextAnimation = "idle_" + neighbours[facing]["right"] + "_" + facing
			set_global_pos(Vector2(get_global_pos().x + 0.5 * distance, get_global_pos().y + 0.5 * distance))
		else:
			nextAnimation = "idle_" + facing + "_" + neighbours[facing]["right"]
			if facing == "up":
				set_global_pos(Vector2(get_global_pos().x + 0.5 * distance, get_global_pos().y - 0.5 * distance))
			else:
				set_global_pos(Vector2(get_global_pos().x + 0.5 * distance, get_global_pos().y + 0.5 * distance))
	
	if event.is_action_released("dodge_left") or event.is_action_released("dodge_right"):
		nextAnimation = "idle_" + facing
		set_global_pos(getPosition(facing, fixpoint, distance))
	
	if event.is_action_pressed("block") and not event.is_echo():
		nextAnimation = "block_" + facing
	
	if event.is_action_released("block"):
		nextAnimation = "idle_" + facing
	
	if event.is_action_pressed("jump") and not event.is_echo():
		if facing == "up":
			animationPlayer.play("jump_" + facing)
			facing = "down"
			set_global_pos(getPosition(facing, fixpoint, distance))
			nextAnimation = "idle_" + facing
	
	if event.is_action_pressed("combo") and not event.is_echo():
		animationPlayer.play("stab_" + facing)
	
func _process(delta):
	
	# adjust animation
	if currentAnimation != nextAnimation:
		currentAnimation = nextAnimation
		animationNode.play(nextAnimation)
