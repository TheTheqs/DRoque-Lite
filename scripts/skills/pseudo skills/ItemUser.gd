extends StatusSkill

class_name ItemUser
var relatedItem: UsableItem
#transferência de dados estáticos baseados no item fornecido
func _init(newItem: UsableItem) -> void:
	self.skillId = -1
	self.skillName = "ItemName" + str(newItem.itemId)
	self.skillIcon = newItem.itemIcon
	self.skillDescription = "ItemDescription" + str(newItem.itemId)
	self.statusType = newItem.itemOrientation
	self.staticPriority = newItem.itemPriority
	self.manaCost = 0
	self.cooldowm = 0
	self.texture = newItem.itemTexture
	self.textureRange = newItem.itemTextureRange
	self.relatedItem = newItem
	self.statusEffects.append(UseItem.new(relatedItem))

#função de ataque de fato
func effect(digimon: Digimon) -> void:
	skillSingularity(digimon)
	applyCooldown(digimon)
	digimon.manaConsumption(self.manaCost)
	if(self.statusType == Enums.StatusType.DEBUFF):
		digimon.enemy.getTageted(self)
	else:
		digimon.getTageted(self)
	if(digimon.tamer is Player):
		var player: Player = digimon.tamer
		player.buttonPanel.updateButtons()
	else:
		var enemy: Enemy = digimon.tamer
		if(relatedItem in enemy.inventory.usableItems.values()):
			print("Vindo aqui")
			enemy.inventory.removeItem(relatedItem, 1)
		
#a função abaixo apenas precisa retornar 0 para nao atrapalhar o cálculo de prioridade do item
func getElementalChartPriority(_digimon: Digimon) -> int:
	return 0
#cálculo de prioridade <3
func priorityCalculation(digimon: Digimon) -> void:
	priority = staticPriority
	priority += relatedItem.iEffect.priorityCalc(digimon)
	if(!usable or currentCooldown != 0 or digimon.currentMana < self.manaCost):
		self.priority = 0
	print(tr(StringName(self.skillName)), " prioridade: ", str(self.priority))
