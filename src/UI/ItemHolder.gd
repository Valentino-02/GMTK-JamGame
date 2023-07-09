extends Control
class_name ItemHolder


signal itemPurchased(itemData, itemCost)

@onready var sprite = $Sprite2D

var holdedItemData: ItemData : 
	set(newValue):
		holdedItemData = newValue
		cost = holdedItemData.itemCost

var cost : int


func _getNextItem() -> void:
	pass

func _purchase() -> void:
	itemPurchased.emit(holdedItemData, cost)
	_getNextItem()


func _on_hero_gold_changed(newValue) -> void:
	if newValue >= cost:
		_purchase()

func _on_change_item_pressed():
	_getNextItem()
