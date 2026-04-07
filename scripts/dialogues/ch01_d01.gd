extends CanvasLayer

func _ready() -> void:
	$Dialogue_box.active_char.connect(_on_char_change)
	$Dialogue_box.end_conversation.connect(_on_conversation_end)
	
func _on_char_change(name: String, color: Color) -> void:
	for i in $PanelContainer.get_children():
		i.get_node("ColorRect").set_color(Color(0, 0, 0, 0.5))
		
	var check_node = $PanelContainer.get_node_or_null(name)
	if check_node:
		$PanelContainer.get_node(name).get_node("ColorRect").set_color(color)
	else:
		print(name, " missing")
		
func _on_conversation_end() -> void:
	visible = false
	$Dialogue_box.visible = false
		
	
