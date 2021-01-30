extends Node

var level
var level_number
# var players = []
export var player_numbers = 1
export var level_path = "res://scenes/level_1.tscn"
export var player_path = "res://scenes/player.tscn"
export var player_container_path : NodePath
onready var player_container = get_node(player_container_path)
export var player_controller_path : NodePath
onready var player_controller = get_node(player_controller_path)






func _ready():
	randomize()
	start_game()
	pass

func start_game():
	load_level()
	load_players(1)
	load_game_ui()

# carga el nivel
func load_level():
	level = load(level_path).instance()
	add_child(level)
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
