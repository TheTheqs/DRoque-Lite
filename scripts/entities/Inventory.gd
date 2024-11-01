extends Node

class_name Inventory
#referências
var relatedTamer: Tamer
var usableItems: Dictionary = {
	
}
var miscItems: Dictionary = {
	
}
#função construtora
func _init(tamer: Tamer) -> void:
	relatedTamer = tamer
#função de adição de item considerando presença e quantidade
func addItem(newItem: Item, quantity: int) -> void:
	newItem.quantity = quantity
	if(quantity != 0):
		if(newItem.isMisc):
			if(miscItems.has(newItem.itemId)):
				if(miscItems[newItem.itemId].quantity + newItem.quantity > 99):
					miscItems[newItem.itemId].quantity = 99
				else:
					miscItems[newItem.itemId].quantity += newItem.quantity
			else:
				miscItems[newItem.itemId] = newItem
		elif(newItem is UsableItem):
			if(usableItems.has(newItem.itemId)):
				if(usableItems[newItem.itemId].quantity + newItem.quantity > 99):
					usableItems[newItem.itemId].quantity = 99
				else:
					usableItems[newItem.itemId].quantity += newItem.quantity
			else:
				usableItems[newItem.itemId] = newItem
	else:
		print("ERROR: Invalid quantity!")

func removeItem(oldItem: Item, quantity) -> void:
	var itemToBeRemoved: Item
	var relatedPocket: Dictionary
	if(oldItem.isMisc and miscItems.has(oldItem.itemId)):
		itemToBeRemoved = miscItems[oldItem.itemId]
		relatedPocket = self.miscItems
	elif(oldItem is UsableItem and usableItems.has(oldItem.itemId)):
		itemToBeRemoved = usableItems[oldItem.itemId]
		relatedPocket = usableItems
	else:
		print("ERROR: Item not found!")
	itemToBeRemoved.quantity -= quantity
	if(itemToBeRemoved.quantity <= 0):
		relatedPocket.erase(oldItem.itemId)

func getInventory() -> Array:
	var fullInventory: Array = usableItems.values() + miscItems.values()
	return fullInventory
