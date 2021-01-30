extends Area2D

onready var circle = get_node("circle")
export var max_radius = 100
export var min_radius = 20
export var radius_exp = 10
var radius : float
var previous_pos = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	previous_pos = global_position
	circle.shape.radius = max_radius
	radius = min_radius
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if previous_pos != global_position:
		previous_pos = global_position
		radius = radius + radius_exp * delta if radius < max_radius else max_radius
	else:
		radius = radius - radius_exp * 4 * delta if radius > min_radius else min_radius
	# circle.shape.radius = floor(radius)


func get_player():
	return get_parent()


# func _on_detection_area_body_entered(body):
# 	print("detecto algo")
# 	if body.is_in_group("gatos"):
# 		print("un gato me escucho")
