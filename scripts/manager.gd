extends Node

var level
var level_number
# var players = []
export var player_numbers = 1
export var level_path = "res://scenes/levels/level_prueba.tscn"
export var player_path = "res://scenes/player.tscn"
export var player_container_path : NodePath
onready var player_container = get_node(player_container_path)
export var player_controller_path : NodePath
onready var player_controller = get_node(player_controller_path)

export var sprite_temp_path : NodePath
onready var sprite_temp = get_node(sprite_temp_path)
var cat_builder

# Buttons & UI


export var ui_main_path : NodePath
onready var  ui_main = get_node(ui_main_path)

# export var btn_singlemode_path : NodePath
# onready var  btn_singlemode = get_node(btn_singlemode_path)
# export var btn_multimode_path : NodePath
# onready var  btn_multimode = get_node(btn_multimode_path)
# export var btn_exit_path : NodePath
# onready var  btn_exit = get_node(btn_exit_path)



func _ready():
	randomize()
	cat_builder = $cat_builder


	#start_game()
	pass

func start_game():
	load_level()
	load_players(1)
	load_game_ui()
	$cat_builder.instance_cat()

# carga el nivel
func load_level():
	level = load(level_path).instance()
	add_child(level)
	cat_builder.level = level
	sprite_temp.position = level.get_random_spawn_point()
	pass


# carga a los jugadores
func load_players(_number):
	if _number > level.get_spawn_list().size():
		_number = level.get_spawn_list().size()
	elif _number == 0:
		_number = 1
	
	var player_loaded = load(player_path)
	for i in range(_number):
		var p = player_loaded.instance()
		player_container.add_child(p)
		p.global_position = level.get_spawn_list()[i].global_position

		player_controller.player = p
		$Camera2D.player = p

# carga la ui de juego
func load_game_ui():
	pass

func on_button_start():
	ui_main.hide()
	start_game()
