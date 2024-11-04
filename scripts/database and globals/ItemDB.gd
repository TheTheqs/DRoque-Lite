extends Node

class_name ItemDataBase
#dictionaries
var itemDataBase: Dictionary = {
	0 : load("res://resources/usable items/RedPotion.tres"),
	1 : load("res://resources/equipments/TrainingSword.tres"),
	2 : load("res://resources/equipments/WoodenClub.tres"),
	3 : load("res://resources/equipments/BasicShirt.tres"),
	4 : load("res://resources/equipments/Zucchetto.tres"),
	5 : load("res://resources/equipments/Torch.tres"),
	6 : load("res://resources/equipments/BasicShield.tres"),
	7 : load("res://resources/equipments/IronNecklace.tres"),
	8 : load("res://resources/equipments/RubyRing.tres"),
}

#funções de retorno
func getUsableItem(itemId: int) -> UsableItem:
	if(itemDataBase.has(itemId)):
		var newUsableItem : UsableItem = UsableItem.new()
		newUsableItem.buildUsableItem(itemDataBase[itemId])
		return newUsableItem
	else:
		print("ERROR: Invalid item id")
		return null

func getEquipment(itemId: int) -> Equipment:
	if(itemDataBase.has(itemId)):
		var newEquipment : Equipment = Equipment.new()
		newEquipment.buildEquipment(itemDataBase[itemId])
		return newEquipment
	else:
		print("ERROR: Invalid item id")
		return null
