extends Node

class_name ItemDataBase
#dictionaries
var miscDataBase: Dictionary = {
	
}
var usableItemDataBase: Dictionary = {
	0 : preload("res://resources/usable items/RedPotion.tres")
}
var equipmentDataBase: Dictionary = {
	
}
#funções de retorno
func getUsableItem(itemId: int) -> UsableItem:
	if(usableItemDataBase.has(itemId)):
		var newUsableItem : UsableItem = UsableItem.new()
		newUsableItem.buildUsableItem(usableItemDataBase[itemId])
		return newUsableItem
	else:
		print("ERROR: Invalid item id")
		return null
