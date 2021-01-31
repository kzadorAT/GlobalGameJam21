extends Node2D


export var spawns_path : NodePath
onready var spawns = get_node(spawns_path)
export var nav_path : NodePath
onready var navigator = get_node(nav_path)


export var tile_path : NodePath
onready var tiles = get_node(tile_path)

var rng = RandomNumberGenerator.new();
onready var offset = (tiles.cell_size.x / 2) * tiles.scale.x

export var calle_id : int
export var cesped_id : int
export var vereda_id : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_spawn_list():
	return spawns.get_children()


# TODO: conseguir un punto random "walkeable" del mapa
func get_random_point(id):
	var street_cells = tiles.get_used_cells_by_id(id)
	rng.randomize();
	var rnumber = rng.randi_range(0, street_cells.size() - 1)
	var random_spawnpoint = street_cells[rnumber]

	print(random_spawnpoint)
	print(random_spawnpoint * tiles.cell_size.x * tiles.scale.x + Vector2(offset, offset))
	return random_spawnpoint * tiles.cell_size.x * tiles.scale.x + Vector2(offset, offset)


func get_random_spawn_point():
	var nrandom = rng.randi_range(0,2)
	match nrandom:
		0:
			return get_random_point(calle_id)
		1:
			return get_random_point(cesped_id)
		2:
			return get_random_point(vereda_id)

func get_spawn_on_vereda():
	return get_random_point(cesped_id)
