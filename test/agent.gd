extends Node2D

export var speed = 100
var path_to_follow = []
export var nav_path : NodePath
onready var nav = get_node(nav_path)
export var finish_pos_path : NodePath
onready var finish_pos = get_node(finish_pos_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	path_to_follow = nav.get_simple_path(global_position,finish_pos.global_position)
	pass # Replace with function body.


func _process(delta):
	if path_to_follow.size() > 0:
		if path_to_follow[0].distance_to(global_position) > speed * delta:
			global_position += to_local(path_to_follow[0]).normalized() * speed * delta
		else:
			translate(to_local(path_to_follow[0]))
			path_to_follow.remove(0)
	pass
