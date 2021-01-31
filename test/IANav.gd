extends Navigation2D

export var tile_map_path : NodePath
onready var tile_map = get_node(tile_map_path)

# Declare member variables here. Examples:
var city_width = 50
var city_height = 60


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(city_height):
		for j in range(city_width):
			tile_map.set_cell(i,j,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
