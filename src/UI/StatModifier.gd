extends NinePatchRect


var stat:String

func set_value(value:int):
	$%Label.text = stat+" : "+str(value)

func construct(_name:String, starter:int, _size:Vector2):
	stat = _name
	set_value(starter)
	size = _size
