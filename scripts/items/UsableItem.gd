extends Item

class_name UsableItem
#variáveis de item usáveis
var itemTexture: CompressedTexture2D #textura para o efeito do item quanto utilizado
var itemTextureRange: int #contador de frames da textura
var itemOrientation: Enums.StatusType
var itemPriority: int = 0
var iEffect: ItemEffect
#atributos exclusivos de disquetes de aprendizagem
var relatedSkill : Skill
var iconDictionary: Dictionary = {
	Enums.Element.DARK : "res://assets/interface/Icons/item icons/usable items/DarkDisket.png",
	Enums.Element.FIRE : "res://assets/interface/Icons/item icons/usable items/FireDisket.png",
	Enums.Element.THUNDER : "res://assets/interface/Icons/item icons/usable items/ElectricDisket.png",
	Enums.Element.WATER : "res://assets/interface/Icons/item icons/usable items/WaterDisket.png",
	Enums.Element.LIGHT : "res://assets/interface/Icons/item icons/usable items/LightDisket.png",
	Enums.Element.WIND : "res://assets/interface/Icons/item icons/usable items/WindDisket.png",
	Enums.Element.PLANT : "res://assets/interface/Icons/item icons/usable items/PlantDisket.png",
	Enums.Element.NEUTRAL : "res://assets/interface/Icons/item icons/usable items/NeutralDisket.png",
	Enums.Element.EARTH : "res://assets/interface/Icons/item icons/usable items/EarthDisket.png",
	"Status": "res://assets/interface/Icons/item icons/usable items/StatusDisket.png",
	"Passive":"res://assets/interface/Icons/item icons/usable items/PassiveDisket.png",
}

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
	self.iEffect.relatedItem = self


#função para ser sobreescrita para cada item utilizável
func itemEffect(digimon: Digimon) -> void:
	self.iEffect.itemEffect(digimon)

#função de cálculo de prioridade para uso do item. 
func priorityCalculation(digimon: Digimon) -> int:
	return self.iEffect.priorityCalc(digimon)

#a função abaixo é específica para itens usáveis de aprendizado de habilidades.
func buildDisket(skillId: int) -> void:
	self.relatedSkill = SkillDB.getSkill(skillId)
	if(self.relatedSkill is StatusSkill):
		self.itemIcon = load(self.iconDictionary["Status"])
	elif(self.relatedSkill is DamageSkill):
		self.itemIcon = load(self.iconDictionary[self.relatedSkill.element])
	else:
		self.itemIcon = load(self.iconDictionary["Passive"])
	self.itemName = self.relatedSkill.skillName
