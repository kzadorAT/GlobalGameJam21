extends Node


export var gato_res = "res://scenes/gato.tscn"
onready var gato_loaded = load(gato_res)
export var gato_ia_res = "res://scenes/IA/cat_bot.tscn"
onready var gato_ia = load(gato_ia_res)
export var container_path : NodePath
onready var container = get_node(container_path)

export (Array,Color) var base_colors
export (Array,Color) var eye_colors

var level

var instanced_cats = {}
var index = 0
var client_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init_cat_builder():
	index = 0
	client_index = 0
	instanced_cats = {}
	pass

func instance_cat():
	# var pos = level.get_random_point()
	var pos = Vector2(2000,3000)
	# aqui para randomizar
	# falta armar para las manchitas
	var base = randi() % base_colors.size()
	var eyes = randi() % eye_colors.size()
	# guardar un diccionario con la info para armar el gato luego
	var dict = {"base" : base, "eyes" : eyes, "index" : index}
	print(base)
	print(eyes)
	instance_by_data(dict,pos)
	instanced_cats[str(index)] = dict
	index += 1


func instance_by_data(dict, pos):
	var gato = get_instanced_dumb_cat(dict)
	container.add_child(gato)
	gato.global_position = pos
	var bot = gato_ia.instance()
	gato.add_child(bot)
	bot.init_bot(level.navigator)

	gato.build_info = dict
	if !instanced_cats.keys().has(str(gato.build_info["index"])):
		# no deberia entrar aqui
		pass


func get_instanced_dumb_cat(dict):
	var gato = gato_loaded.instance()
	gato.set_base_color(base_colors[dict["base"]])
	gato.set_eyes_color(eye_colors[dict["eyes"]])
	return gato


func get_cat_info():
	var dict = instanced_cats[str(client_index)]
	client_index += 1
	return dict
