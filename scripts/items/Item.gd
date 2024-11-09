extends Node

class_name Item
#identificação
var itemId: int
var itemName: String
var itemDescription: String
var itemIcon: CompressedTexture2D
var isMisc: bool
var canUse: bool = true
#elementos dinâmicos
var quantity: int = 1

#função para constução de itens misc (não interativos)
func buildMisc(stats: MiscItemData) -> void:
	self.itemId = stats.itemId
	self.itemName = "ItemName" + str(self.itemId)
	self.itemDescription = "ItemDescription" + str(self.itemId)
	self.itemIcon = stats.itemIcon
	self.isMisc = true
