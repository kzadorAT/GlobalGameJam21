extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var spawns_path : NodePath
onready var spawns = get_node(spawns_path)

export var building : String
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(15):
		var inMemory = load(building)
		var loaded = inMemory.instance()
		add_child(loaded)
		loaded.global_position = Vector2(i * 210, 300)
		pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
