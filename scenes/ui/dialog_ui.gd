extends Control

@onready var name_label = $SpeakerBox/Label
@onready var text_label = $DialogBox/RichTextLabel
@onready var overlay = $BackgroundOverlay # Node baru tadi

func show_dialog(speaker_name: String, message: String):
	name_label.text = speaker_name
	text_label.text = message
	overlay.show() # Munculin tirai hitam
	self.show()

func hide_dialog():
	overlay.hide() # Sembunyiin tirai hitam
	self.hide()
