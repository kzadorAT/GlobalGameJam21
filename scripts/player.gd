extends KinematicBody2D

signal is_moving


export var speed = 100
var toy = false
var near_cats = []
var catched_cat_info = {}
var manager

export var animation_path : NodePath
onready var anim = get_node(animation_path)


export var visual_path : NodePath
onready var visual = get_node(visual_path)
var scale_x
var timer
# Called when the node enters the scene tree for the first time.
func _ready():
	scale_x = visual.scale.x
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout",self,"stop_anim")
	anim.play("Rest")
	pass # Replace with function body.


func move(direction):
	#look_at(global_position + direction)
	direction = direction.normalized() * speed
	direction = move_and_slide(direction)
	if(((direction.x != 0) || (direction.y != 0)) && (!anim.is_playing() or anim.current_animation != "Walk")):

		anim.play("Walk")
	if(direction == Vector2.ZERO):
		anim.play("Rest")
	# por si esta caminando contra una pared
	# if direction != Vector2.ZERO:
	# 	emit_signal("is_moving")
	if direction.x < 0:
		visual.scale.x = -scale_x
	else:
		visual.scale.x = scale_x
	timer.start(.2)
# atrapa a un gato
func catch(gato):
	if near_cats.has(gato):
		if !catched_cat_info.empty():
			# soltar el gato que tenga en la mano
			manager.cat_builder.instance_by_data(catched_cat_info, gato.global_position)
		# recojo al gato
		catched_cat_info = gato.build_info
		gato.queue_free()


# entrego el gato al cliente
func deliver_cat(client):
	if client.cat_info == catched_cat_info:
		catched_cat_info.clear()
		client.cat_received()
		return true
	else: 
		return false


func has_toy():
	return toy


func _on_catch_area_body_entered(body):
	if body.is_in_group("gatos"):
		near_cats.append(body)


func _on_catch_area_body_exited(body):
	if body.is_in_group("gatos"):
		near_cats.erase(body)


func stop_anim():
	anim.play("Rest")
