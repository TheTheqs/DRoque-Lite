extends Skill

class_name StatusSkill
#status skill
var statusEffects: Array[StatusEffect]
var statusType: Enums.StatusType

#transferência de dados estáticos
func setStats(stats: StatusSkillData) -> void:
	self.skillId = stats.skillId
	self.skillName = "SkillName" + str(self.skillId)
	self.skillIcon = stats.skillIcon
	self.skillDescription = "SkillDescription" + str(self.skillId)
	self.statusType = stats.statusType
	self.staticPriority = stats.staticPriority
	self.manaCost = stats.manaCost
	self.cooldowm = stats.coolDown
	self.texture = stats.skillTexture
	self.textureRange = stats.textureRange

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
		
	
#A função abaixo só é usada quando o bool has stats for True
func applyStats(_digimon: Digimon) -> void:
	pass
#função abistrada que vai executar comandos específicos de cada skill caso houver
func skillSingularity(_digimon: Digimon) -> void:
	pass
#aqui eu reaproveitei uma função. Em habildiades de status, ela vai gerar prioridade caso o jogador tenha mais ações.
func getElementalChartPriority(digimon: Digimon) -> int:
	var verifyPriority: int = modifyPriority(digimon)
	if(verifyPriority != 0):
		priority += verifyPriority
		if(digimon.tamer.actions > 1):
			return 3
		else:
			return 0
	else:
		return 0

func modifyPriority(digimon: Digimon) -> int:
	var intToReturn: int = 0
	for nStatus: StatusEffect in self.statusEffects:
		if(nStatus.statusType == Enums.StatusType.BUFF):
			if((not nStatus.isStackable and digimon.statusEffect.has(nStatus.statusId)) or (nStatus.isStackable and digimon.statusEffect.has(nStatus.statusId) and nStatus.stacks >= nStatus.stacksLimit)):
				intToReturn = 0
			elif(nStatus.isStackable and digimon.statusEffect.has(nStatus.statusId) and nStatus.stacks < nStatus.stacksLimit):
				intToReturn += 1
		else:
			if((not nStatus.isStackable and digimon.enemy.statusEffect.has(nStatus.statusId)) or (nStatus.isStackable and digimon.enemy.statusEffect.has(nStatus.statusId) and nStatus.stacks >= nStatus.stacksLimit)):
				intToReturn = 0
			elif(nStatus.isStackable and digimon.enemy.statusEffect.has(nStatus.statusId) and nStatus.stacks < nStatus.stacksLimit):
				intToReturn += 1
	return intToReturn
