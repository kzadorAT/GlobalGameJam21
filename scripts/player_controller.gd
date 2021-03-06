extends Node


var direction = Vector2.ZERO
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	# player = get_node("../player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if weakref(player).get_ref():
		direction = Vector2.ZERO
		if Input.is_action_pressed("ui_right"):
			direction.x = 1
		if Input.is_action_pressed("ui_left"):
			direction.x = -1
		if Input.is_action_pressed("ui_up"):
			direction.y = -1
		if Input.is_action_pressed("ui_down"):
			direction.y = 1
		if direction != Vector2.ZERO:
			player.move(direction.normalized())



func on_cat_picked(_v, event, _i, gato):  
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			player.catch(gato)
	pass


func deliver_cat(_v, event, _i, client):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			player.deliver_cat(client)
	pass
