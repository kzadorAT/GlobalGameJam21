extends KinematicBody2D

signal is_moving


export var speed = 100
var toy = false
var near_cats = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(direction):
	look_at(global_position + direction)
	direction = direction.normalized() * speed
	direction = move_and_slide(direction)
	# por si esta caminando contra una pared
	# if direction != Vector2.ZERO:
	# 	emit_signal("is_moving")


func catch(gato):
	if near_cats.has(gato):
		# recojo el gato
		pass
	pass


func has_toy():
	return toy


func _on_catch_area_body_entered(body):
	if body.is_in_group("gatos"):
		near_cats.append(body)


func _on_catch_area_body_exited(body):
	if body.is_in_group("gatos"):
		near_cats.erase(body)


