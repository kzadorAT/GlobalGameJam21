extends Node


## interno
var state_stack = []
var physics_stack = ["escaping", "attracted"]
export var gato_path : NodePath
onready var gato = get_node(gato_path)

## nav mesh
var navigator
var escape_path = []
var random_point = Vector2(0,0)

## transition vbles
# desde sensores
var player_near = false
var player = null
var player_toy = false
# desde el inspector
export var arisquidad_max = 10.0
export var arisquidad_actual  = 0.0
export var arisquicidad_accel = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	init_bot()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state_stack.size() > 0 and self.has_method(state_stack.back()):
		if !physics_stack.has(state_stack.back()):
			self.call(state_stack.back())

func _physics_process(_delta):
	if state_stack.size() > 0 and self.has_method(state_stack.back()):
		if physics_stack.has(state_stack.back()):
			self.call(state_stack.back())

func init_bot():
	state_stack.clear()
	push_state("idle")


func push_state(state):
	state_stack.push_back(state)


func pop_state():
	state_stack.pop_back()

# states
#==========================

# en reposo
func idle():
	if player_near:
		push_state("alert")

# cuando detecta al jugador
func alert():
	if player_near and arisquidad_actual > arisquidad_max:
		push_state("escaping")
		return
	elif !player_near:
		arisquidad_actual = 0
		pop_state()
		return
	if player_toy:
		push_state("attracted")
		return
	arisquidad_actual += arisquicidad_accel * get_process_delta_time()

# asustado y escapando
func escaping():
	# si escape del jugador
	if !player_near:
		# limpio y salgo del estado
		escape_path.clear()
		pop_state()
		return
	
	# calculo un path si no lo tengo
	if escape_path.size() == 0:
		escape_path = navigator.get_simple_path(gato.global_position, random_point)
	# si llegue a un punto en el path lo borro
	if escape_path.front().distance_to(gato.global_position) < gato.run_speed * get_process_delta_time():
		escape_path.pop_front()
		# si me quedara sin puntos recalculo en el siguiente frame
		# (o simplemente podria volver a llamar a escaping de manera recursiva, pero no me gusta)
		if escape_path.size() == 0:
			return
	else:
		# me muevo hacia el siguiente punto en mi path
		gato.run(gato.to_local(escape_path.front()).normalized())


# atraido por un juguete o comida
func attracted():
	if !player_toy:
		pop_state()
		return
	# si estoy cerca camino hacia el jugador
	if player and player_near:
		gato.move(gato.to_local(player_near.global_position))
	# si estoy lejos corro hacia el jugador
	if player and !player_near:
		gato.run(gato.to_local(player_near.global_position))


# capturado
# la verdad no se bien que hacer aqui, ni de donde llamarlo
func captured():
	pass

#==========================