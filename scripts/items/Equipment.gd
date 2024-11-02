extends Item

class_name Equipment
#variáveis de equipamento
var equipType: Enums.EquipmentType
var equipmentAttribute1: 

func buildUsableItem(stats: UsableItemData) -> void:
	self.itemId = stats.itemId
	self.itemName = "ItemName" + str(self.itemId)
	self.itemDescription = "ItemDescription" + str(self.itemId)
	self.itemIcon = stats.itemIcon
	self.isMisc = false
	self.itemTexture = stats.itemTexture
	self.itemTextureRange = stats.itemTextureRange
	self.itemOrientation = stats.itemOrientation
	self.iEffect = stats.itemEffect.new()
