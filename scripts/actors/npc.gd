extends Node2D

@onready var interaction_area: InteractionArea = $weirdo/InteractionArea

const lines: Array[String] = ["Hey Mizi"]

func _ready():

	if interaction_area:
		interaction_area.interact = _on_interact
	else:
		print("ERROR: InteractionArea gak ketemu di npc.gd!")

func _on_interact():

	InteractionManager.set_process(false) 
	
	InteractionManager.label.text = lines[0]
	InteractionManager.label.show()
	
	await get_tree().create_timer(3.0).timeout
	
	InteractionManager.set_process(true)
	InteractionManager.can_interact = true
