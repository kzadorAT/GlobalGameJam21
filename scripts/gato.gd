extends KinematicBody2D

signal is_walking
signal is_running

export var walk_speed = 50
export var run_speed = 120

export (Array,NodePath) var piezas_base
export var piezas_ojos : NodePath

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("caminar")
	pass # Replace with function body.


func move(_direction):
	_direction = move_and_slide(_direction.normalized() * walk_speed)
	emit_signal("is_walking")
	pass

func run(_direction):
	_direction = move_and_slide(_direction.normalized() * run_speed)
	emit_signal("is_running")
	pass


func set_base_color(color):
	for pieza in piezas_base:
		get_node(pieza).color = color
	pass

func set_eyes_color(color):
	get_node(piezas_ojos).color = color
