extends Node2D


export var spawns_path : NodePath
onready var spawns = get_node(spawns_path)
export var nav_path : NodePath
onready var navigator = get_node(nav_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_spawn_list():
	return spawns.get_children()


# TODO: conseguir un punto random "walkeable" del mapa
func get_random_point():
	pass

