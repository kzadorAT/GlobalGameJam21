extends KinematicBody2D

signal is_moving


export var speed = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move(direction):
	look_at(global_position + direction)
	direction = direction.normalized() * speed
	direction = move_and_slide(direction)
	# por si esta caminando contra una pared
	if direction != Vector2.ZERO:
		emit_signal("is_moving")


func catch():
	pass
