extends NinePatchRect

# didn't add signals 'cause I assume we'd just use the ones from the buttons

var stat:String

func set_value(value:int):
	$%Label.text = stat+" : "+str(value)

func construct(_name:String, starter:int, _size:Vector2):
	stat = _name
	set_value(starter)
	size = _size


func _on_minus_pressed():
	$%Minus.get_node("GPUParticles2D").emitting = true


func _on_plus_pressed():
	$%Plus.get_node("GPUParticles2D").emitting = true
