extends Button
class_name EntityHolder


signal askCanDropHere(position: Vector2, entityData: Resource)

@onready var sprite = $Sprite

var holdedEntityData: Resource 
var isPressed : bool :
	set(newValue):
		isPressed = newValue
		if isPressed == false:
			sprite.position = Vector2.ZERO

var canPay : bool :
	set(newValue):
		canPay = newValue
		if canPay == true:
			sprite.modulate = Color(1,1,1,1)
		if canPay == false:
			sprite.modulate = Color(1,1,1,0.5)


func _process(delta):
	if isPressed:
		sprite.position = get_local_mouse_position()


func on_artist_energy_changed(newValue) -> void:
	if holdedEntityData == null:
		return
	canPay = newValue >= holdedEntityData.deployCost


func _getNextEntity() -> void:
	pass


func _on_button_down():
	if not canPay:
		return
	isPressed = true

func _on_button_up():
	if not isPressed:
		return
	var mousePos = get_global_mouse_position()
	askCanDropHere.emit(mousePos,holdedEntityData )
	isPressed = false

func _on_drop_confirmation() -> void:
	_getNextEntity()
