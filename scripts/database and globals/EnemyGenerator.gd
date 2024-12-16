extends Node

class_name EnemyGenerator
#essa classe vai "segurar" dados da campanha!
var playerLevel: int
var playerCurrentChoice: int = 0 #define o digimon que o jogador está no momento
var playerInventory: Array[Item] #array que será inserido no inventário do jogador.
var playerKarma: Enums.Karma
var partyMembers: Array[int]
var currentTamer: Tamer
#Dicionários do grupo
var playerParty: Dictionary = { #guarda os IDs de cada digimon do jogador
	0 : null,
	1 : null,
	2 : null
	}
var digimonActiveSkills: Dictionary = {
	0 : [ThornyThrust.new(), FieryFlicker.new(), ShadowSlice.new()], #esses arrays precisam ter de prefencia size fixo em 3
	1 : [null, null, null],
	2 : [null, null, null],
	}
#passivas comuns do grupo
var fixedPassives: Dictionary = { #a chave vai ser o id da passiva, o valor vai ser um array de tamanho 2, o primeiro é a skill o segundo é contagem dela
	65: [SurvivalBaton.new(), 1]
}

var currentEquipments: Dictionary = { #equipamento de cada digimon um array de tamanho máximo de 4
	0 : [],
	1 : [],
	2 : []
}
var currentStatus: Dictionary = { #Status Effect ativos em cada Digimon
	0 : [],
	1 : [],
	2 : []
}

var currentHealthMana: Dictionary = { #proporção da vida de cada digimon 
	0 : [1, 1],
	1 : [1, 1],
	2 : [1, 1]
}

var currentCoolDown: Dictionary = {
	0 : [0, 0, 0, 0, 0],
	1 : [0, 0, 0, 0, 0],
	2 : [0, 0, 0, 0, 0]
}
#função init para teste
func loadContent() -> void:
	self.playerLevel = self.calculateLevel()
	self.playerKarma = Enums.Karma.TREACHEROUS
	#teste de grupo
	self.addToParty(Util.random(0,5))
	self.addToParty(Util.random(0,5))
	self.addToParty(Util.random(0,5))
	#teste de equipamento
	currentEquipments[0].append(ItemDB.getEquipment(2))
	#teste de inventário

func addToParty(digimonId: int) -> bool:
	var sucess: bool = false
	for key: int in playerParty:
		if(playerParty[key] == null):
			playerParty[key] = digimonId
			self.addPassive(digimonId)
			sucess = true
			break
	return sucess
#função que remove digimon da party
func removeFromParty(index: int) -> void:
	var removedId: int = SkillDB.getPassiveId(DDB.getDigimonData(playerParty[index]).digimonId)
	if(self.fixedPassives.has(removedId)):
		self.fixedPassives[removedId][1] -= 1
		if(self.fixedPassives[removedId][1] <= 0):
			self.fixedPassives.erase(removedId)
		self.partyMembers.erase(self.playerParty[index])
		self.playerParty[index] = null
	else:
		print("ERROR: No Skill found!")
	if(index != self.playerCurrentChoice):
		if(self.currentEquipments[index].size() > 0):
			for equip: Equipment in self.currentEquipments[index]:
				if(equip != null):
					self.playerInventory.append(equip)
					self.currentTamer.inventory.addItem(equip, 1)
		self.currentEquipments[index] = []
		self.currentCoolDown[index] = [0, 0, 0, 0, 0]
		self.currentStatus[index] = []

#função de teste que gera arrays com valores únicos

#função de teste que gera um full set para o Digimon
func getFullSet() -> Array:
	return [ItemDB.getEquipment(Util.pickOne(ItemDB.weapons)), ItemDB.getEquipment(Util.pickOne(ItemDB.offHands)), ItemDB.getEquipment(Util.pickOne(ItemDB.armors)), ItemDB.getEquipment(Util.pickOne(ItemDB.accessories))]

func calculateLevel()-> int:
	var possibleLevels: Array[int] = [Campaign.playerLevel - 2, Campaign.playerLevel + 2,]
	return max(1, Util.random(possibleLevels[0], possibleLevels[1]))

func addPassive(digimonId: int)-> void:
	var passiveSkill: PassiveSkill = SkillDB.getNative(digimonId, 0)
	if(self.fixedPassives.has(passiveSkill.skillId)):
		self.fixedPassives[passiveSkill.skillId][1] += 1
	else:
		self.fixedPassives[passiveSkill.skillId] = [SkillDB.getNative(digimonId, 0), 1]
	self.partyMembers.append(digimonId)
