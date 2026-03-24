extends CanvasLayer

var file
@onready var Char = $PanelContainer/VBoxContainer/PanelContainer/MarginContainer/Char
@onready var Text = $PanelContainer/VBoxContainer/PanelContainer2/MarginContainer2/HBoxContainer/Text

func _ready() -> void:
	file = FileAccess.open("res://assets/dialogue/dummy.txt", FileAccess.READ)
	if file:
		display()
	else:
		print("file does not exist")

func char_check() -> String:
	var line = file.get_line()
	if line == "/m":
		Char.set_text("Mizi")
		return file.get_line()
	elif line == "/i":
		Char.set_text("Ivan")
		return file.get_line()
	elif line == "/n":
		Char.set_text("(Narrator)")
		return file.get_line()
	return line
	
func display() -> void:
	while file.get_position() < file.get_length():
		var line = char_check()
		Text.set_text(line)
		await get_tree().create_timer(2.0).timeout
	visible = 0
	file.close()
