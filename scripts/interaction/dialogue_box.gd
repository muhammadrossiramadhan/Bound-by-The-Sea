extends CanvasLayer

var file
var active_color = Color(0, 0, 0, 0)
signal active_char(name: String, color: Color)
signal end_conversation()
@onready var Char = %Char
@onready var Text = %Text

func _ready() -> void:
	file = FileAccess.open("res://assets/dialogue/dummy.txt", FileAccess.READ)
	if file:
		display()
	else:
		print("file does not exist")

func char_check() -> String:
	var line = file.get_line()
	match line:
		"/m":
			active_char.emit("Mizi", active_color)
			Char.set_text("Mizi")
			return file.get_line()
		"/i":
			active_char.emit("Ivan", active_color)
			Char.set_text("Ivan")
			return file.get_line()
		"/n":
			active_char.emit("Narrator", active_color)
			Char.set_text("(Narrator)")
			return file.get_line()
	return line
	
func display() -> void:
	while file.get_position() < file.get_length():
		var line = char_check()
		Text.set_text(line)
		await get_tree().create_timer(2.0).timeout
	end_conversation.emit()
	file.close()
