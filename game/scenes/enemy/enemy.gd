extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var initDist = 64
var offset = 16

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)

func keepDistance(fixpoint):
	var diff = get_global_pos()-fixpoint
	var currentDist = get_global_pos().distance_to(fixpoint)
	if (currentDist > initDist + offset):
		if (abs(diff.x) > abs(diff.y)):
			set_global_pos(Vector2(fixpoint.x, get_global_pos().y))
		else:
			set_global_pos(Vector2(get_global_pos().x, fixpoint.y))

func attack(fixpoint):
	pass

func _fixed_process(delta):
	var fixpoint = get_parent().get_node("Hero").get_pos()
	keepDistance(fixpoint)