extends AudioStreamPlayer

export(Array, AudioStream) var audio_streams

func random_play():
	stream = audio_streams[randi() % len(audio_streams)]
	play()
