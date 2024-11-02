extends Item

class_name UsableItem
#variáveis de item usáveis
var itemTexture: CompressedTexture2D #textura para o efeito do item quanto utilizado
var itemTextureRange: int #contador de frames da textura
var itemOrientation: Enums.StatusType
var itemPriority: int = 0
var iEffect: ItemEffect

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

#função para ser sobreescrita para cada item utilizável
func itemEffect(digimon: Digimon) -> void:
	self.iEffect.itemEffect(digimon)

#função de cálculo de prioridade para uso do item. 
func priorityCalculation(digimon: Digimon) -> int:
	print("Vindo aqui")
	return self.iEffect.priorityCalc(digimon)
