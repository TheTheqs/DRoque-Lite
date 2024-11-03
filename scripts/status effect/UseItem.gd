extends StatusEffect

class_name UseItem
#value
var relatedItem: Item

func _init(item: Item) -> void:
	self.statusId = 41
	relatedItem = item
	if(item is UsableItem):
		self.statusType = item.itemOrientation
	else:
		self.statusType = Enums.StatusType.BUFF

func applyingEffect(digimon: Digimon) -> void:
	if(relatedItem is UsableItem):
		relatedItem.itemEffect(digimon)
	elif(relatedItem is Equipment):
		digimon.equipItem(relatedItem)

func getStatus() -> StatusEffect:
	return UseItem.new(relatedItem)
