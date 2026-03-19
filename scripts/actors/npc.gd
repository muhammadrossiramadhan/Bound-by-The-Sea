extends Node2D

@onready var interaction_area: InteractionArea = $weirdo/InteractionArea

const npc_name = "WEIRDO"
const lines: Array[String] = [
	"HEY MIZI, I'M WEIRDO, YOU CAN CALL ME ANYTHING.",
	"I WILL REPORT THE NEW ISSUES OF OUR CORAL CITY."
]

func _ready():

	InteractionManager.is_dialog_active = true

func _on_interact():
	# CARA OTOMATIS: Cari UI di dalam pohon scene world
	var dialog_box = get_tree().root.find_child("DialogUI", true, false)
	var portrait = get_tree().root.find_child("CharacterDialogue", true, false)
	
	if dialog_box and portrait:
		# Matikan sistem interaksi "PRESS E"
		InteractionManager.can_interact = false
		InteractionManager.label.hide()
		
		# TAMPILKAN UI & PORTRAIT
		portrait.show()
		dialog_box.show_dialog(npc_name, lines[0])
		
		# Tunggu 4 detik (biar bisa baca)
		await get_tree().create_timer(4.0).timeout
		
		# SEMBUNYIKAN KEMBALI
		portrait.hide()
		dialog_box.hide()
		
		# Aktifkan kembali sistem interaksi
		InteractionManager.can_interact = true
	else:
		# Kalau error, ini akan kasih tahu node mana yang namanya salah
		if not dialog_box: print("ERROR: Node 'DialogUI' tidak ketemu!")
		if not portrait: print("ERROR: Node 'CharacterDialogue' tidak ketemu!")
