extends Area2D


# Declare member variables here. Examples:
export var bot_path : NodePath
onready var bot = get_node(bot_path)
var areas = []
var areas_flags = []

func _process(_delta):
	for i in range(areas.size()):
		if global_position.distance_to(areas[i].global_position) < areas[i].radius:
			if !areas_flags[i]:
				areas_flags[i] = true
				var _player = areas[i].get_player()
				bot.add_player(_player, _player.has_toy())

			pass


func _on_player_detector_area_entered(area):
	if area.is_in_group("detection_area"):
		areas.append(area)
		areas_flags.append(false)
		# var _player = area.get_player()
		# bot.add_player(_player, _player.has_toy())


func _on_player_detector_area_exited(area):
	if areas.has(area):
		var i = areas.find(area)
		areas.erase(area)
		areas_flags.remove(i)
		bot.remove_player()
	# if area.is_in_group("detection_area"):
	# 	bot.remove_player()