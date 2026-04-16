extends Node

var player1: AudioStreamPlayer
var player2: AudioStreamPlayer
var active_player: AudioStreamPlayer

func _ready():
	player1 = AudioStreamPlayer.new()
	add_child(player1)
	player2 = AudioStreamPlayer.new()
	add_child(player2)
	active_player = player1

func play_music(music_path: String, fade_duration: float = 2.0):
	var new_stream = load(music_path)
	if active_player.stream == new_stream:
		return
	
	var next_player = player2 if active_player == player1 else player1
	next_player.stream = new_stream
	next_player.volume_db = -80
	next_player.play()
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(active_player, "volume_db", -80, fade_duration)
	tween.tween_property(next_player, "volume_db", 0, fade_duration)
	
	active_player = next_player
