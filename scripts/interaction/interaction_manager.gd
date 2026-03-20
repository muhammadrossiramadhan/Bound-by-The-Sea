extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = %Label

const base_text = "PRESS [E] TO "

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(_delta):
	if active_areas.size() > 0 and can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		
		var current_area = active_areas[0]
		label.text = base_text + current_area.action_name
		
		# AMBIL POSISI GLOBAL NPC
		var target_pos = current_area.global_position
		
		# SET POSISI LABEL
		label.global_position = target_pos
		label.global_position.y -= 120 # Geser ke atas kepala
		label.global_position.x -= label.size.x / 2 # Center secara horizontal
		
		label.show()
		
	else:
		label.hide()

func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _input(event):
	if event.is_action_pressed("interactTalk") and can_interact:
		if active_areas.size() > 0:
			can_interact = false
			
			# Sesuaikan dengan nama variabel di InteractionArea.gd kamu
			await active_areas[0].interact.call()
			
			can_interact = true
