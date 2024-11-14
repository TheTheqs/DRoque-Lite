extends Node

class_name ItemDataBase
var usablesIds: Array[int] = [0, 9]
var weapons: Array[int] = [1, 2]
var armors: Array[int] = [3, 4]
var offHands : Array[int] = [5, 6]
var accessories: Array[int] = [7, 8]
#dictionaries
var itemDataBase: Dictionary = {
	0 : "res://resources/usable items/RedPotion.tres",
	1 : "res://resources/equipments/TrainingSword.tres",
	2 : "res://resources/equipments/WoodenClub.tres",
	3 : "res://resources/equipments/BasicShirt.tres",
	4 : "res://resources/equipments/Zucchetto.tres",
	5 : "res://resources/equipments/Torch.tres",
	6 : "res://resources/equipments/BasicShield.tres",
	7 : "res://resources/equipments/IronNecklace.tres",
	8 : "res://resources/equipments/RubyRing.tres",
	9 : "res://resources/usable items/UpgradeI.tres"
}

#funções de retorno
func getUsableItem(itemId: int) -> UsableItem:
	if(itemDataBase.has(itemId)):
		var newUsableItem : UsableItem = UsableItem.new()
		newUsableItem.buildUsableItem(load(itemDataBase[itemId]))
		return newUsableItem
	else:
		print("ERROR: Invalid item id")
		return null

func getEquipment(itemId: int) -> Equipment:
	if(itemDataBase.has(itemId)):
		var newEquipment : Equipment = Equipment.new()
		newEquipment.buildEquipment(load(itemDataBase[itemId]))
		return newEquipment
	else:
		print("ERROR: Invalid item id")
		return null
