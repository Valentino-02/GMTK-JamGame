extends AudioStreamPlayer


func _play(_stream):
	stream = _stream
	play()
