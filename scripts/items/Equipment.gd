extends Item

class_name Equipment
#variáveis de equipamento
var equipType: Enums.EquipmentType
var equipTier: Enums.EquipmentTier
var attBuffs: Array[int] = [0, 0, 0, 0, 0, 0]
var buffAdress: Array[String] = ["str", "int", "agi", "vit", "wis", "dex"]
var maxBuffs: int
var buffedAttributes: Array[String]
var itemPassives: Array[PassiveSkill]
var isWeapon: bool = false
var weaponTexture: CompressedTexture2D
var textureRange: int
#no array, o primeiro valor é o padrão, o segundo é o valor mínimo adicional e o terceiro é o valor máximo adicional
var buffRegulator: Dictionary ={
	Enums.EquipmentTier.COMMON: [7 + int(floor(Campaign.campaignLevel * 0.1)), -1, 2],
	Enums.EquipmentTier.RARE: [10 + int(floor(Campaign.campaignLevel * 0.2)), 2, 5],
	Enums.EquipmentTier.EPIC: [15 + int(floor(Campaign.campaignLevel * 0.3)), 3, 6],
	Enums.EquipmentTier.LEGENDARY: [20 + int(floor(Campaign.campaignLevel * 0.4)), 5, 8],
}

func buildEquipment(stats: EquipmentData) -> void:
	self.itemId = stats.itemId
	self.itemName = "ItemName" + str(self.itemId)
	self.itemDescription = "ItemDescription" + str(self.itemId)
	self.itemIcon = stats.itemIcon
	self.equipType = stats.itemEquipmentType
	self.equipTier = stats.equipmentTier
	self.maxBuffs = buffRegulator[self.equipTier][0] + Util.random(Campaign.campaignLevel + buffRegulator[self.equipTier][1], Campaign.campaignLevel + buffRegulator[self.equipTier][2])
	self.buffedAttributes = stats.buffedAttributes.duplicate()
	self.buildBuffs()
	self.isMisc = false
	if(stats.isWeapon):
		self.isWeapon = true
		self.weaponTexture = stats.weaponTexture
		self.textureRange = stats.textureRange
	if(stats.itemPassives.size() > 0):
		for passive: Script in stats.itemPassives:
			itemPassives.append(passive.new())

func buildBuffs() -> void:
	# Inicializa uma quantidade de pontos para distribuir
	var remainingBuffs = maxBuffs
	while remainingBuffs > 0:
		var randomAttribute = Util.pickOne(buffedAttributes)
		var index = buffAdress.find(randomAttribute)
		var buffValue = Util.random(1, min(remainingBuffs, 3))
		attBuffs[index] += buffValue
		remainingBuffs -= buffValue
