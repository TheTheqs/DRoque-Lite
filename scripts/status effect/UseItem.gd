extends StatusEffect

class_name UseItem
#value
var relatedItem: UsableItem

func _init(item: UsableItem) -> void:
	self.statusId = 41
	relatedItem = item
	self.statusType = item.itemOrientation

func applyingEffect(digimon: Digimon) -> void:
	relatedItem.itemEffect(digimon)

func getStatus() -> StatusEffect:
	return UseItem.new(relatedItem)
