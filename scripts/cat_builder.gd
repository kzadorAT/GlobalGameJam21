extends Node


export var gato_path = "res://scenes/gato.tscn"
var gato_loaded
export var container_path : NodePath
onready var container = get_node(container_path)

export (Array,Color) var base_colors
export (Array,Color) var eye_colors

var level
# Called when the node enters the scene tree for the first time.
func _ready():
	gato_loaded = load(gato_path)
	pass # Replace with function body.


func instance_cat():
	# var pos = level.get_random_point()
	var pos = Vector2(2000,3000)
	var gato = gato_loaded.instance()
	# aqui para randomizar
	var base = randi() % base_colors.size()
	var eyes = randi() % eye_colors.size()
	print(base)
	print(eyes)
	gato.set_base_color(base_colors[base])
	gato.set_eyes_color(eye_colors[eyes])
	container.add_child(gato)
	gato.global_position = pos
	gato.get_node("bot").init_bot(level.navigator)
	pass


