extends Node2D


var manager
var cat_info = {}
export var gato_globo_path : NodePath
onready var gato_globo = get_node(gato_globo_path)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.



func set_cat():
	cat_info = manager.cat_builder.get_cat_info()
	var gato_dumb = manager.cat_builder.get_instanced_dumb_cat(cat_info)
	gato_globo.add_child(gato_dumb)


func cat_received():
	# animacion de contento y mando señal al manager
	pass


func _on_player_near(body):
	if body.is_in_group("player"):
		# muestro el globo con el gatito
		pass

func _on_player_exit(body):
	if body.is_in_group("player"):
		# oculto el globo con el gatito
		pass