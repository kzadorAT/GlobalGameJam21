extends Camera2D


var player

# Called when the node enters the scene tree for the first time.
func _ready():
	# player = get_node("../player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if weakref(player).get_ref():
		global_position = player.global_position
	pass
