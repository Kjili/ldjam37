extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var initDist = 64
var offset = 16
var facing
var attackRange = 2
var animationNode
var animationPlayer

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	animationNode = get_node("AnimatedSprite")
	animationPlayer = get_node("AnimationPlayer")
	set_fixed_process(true)

func keepDistance(fixpoint):
	var diff = get_global_pos()-fixpoint
	var currentDist = get_global_pos().distance_to(fixpoint)
	if currentDist > initDist + offset:
		if abs(diff.x) > abs(diff.y):
			set_global_pos(Vector2(fixpoint.x, get_global_pos().y))
			if diff.y >= 0:
				facing = Vector2(0,-1)
				animationNode.play("idle_up")
			else:
				facing = Vector2(0,1)
				animationNode.play("idle_down")
		else:
			set_global_pos(Vector2(get_global_pos().x, fixpoint.y))
			if diff.x >= 0:
				facing = Vector2(-1,0)
				animationNode.play("idle_left")
			else:
				facing = Vector2(1,0)
				animationNode.play("idle_right")
		animationNode.set_hidden(false);
		get_node("AttackVertical").set_hidden(true);
		get_node("AttackHorizontal").set_hidden(true);

func attack(fixpoint):
	if get_global_pos().y > fixpoint.y-attackRange and get_global_pos().y < fixpoint.y+attackRange:
		if facing == Vector2(1,0):
			animationPlayer.play("StabRight")
		if facing == Vector2(-1,0):
			pass#get_node("AnimationPlayer").play("StabRight")
	if get_global_pos().x > fixpoint.x-attackRange and get_global_pos().x < fixpoint.x+attackRange:
		if facing == Vector2(0,1):
			animationPlayer.play("StabDown")
		if facing == Vector2(0,-1):
			pass#get_node("AnimationPlayer").play("StabUp")

func _fixed_process(delta):
	var fixpoint = get_parent().get_node("Hero").get_pos()
	keepDistance(fixpoint)
	attack(fixpoint)