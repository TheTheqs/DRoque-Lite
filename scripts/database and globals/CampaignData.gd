extends Node

class_name CampaignData
#essa classe vai "segurar" dados da campanha!
var campaignLevel: int = 3 #Define o nível dos inimigos e as recomenpensas
var playerLevel: int = 3 #define a força do personagem 
var playerCurrentChoice: int = 0 #define o digimon que o jogador está no momento
var playerInventory: Array[Item] #array que será inserido no inventário do jogador.
#Dicionários do grupo
var playerParty: Dictionary = { #guarda os IDs de cada digimon do jogador
	0 : null,
	1 : null,
	2 : null
	}
var digimonActiveSkills: Dictionary = {
	0 : [], #esses arrays precisam ter de prefencia size fixo em 3
	1 : [],
	2 : [],
	}
#passivas comuns do grupo
var fixedPassives: Dictionary = { #a chave vai ser o id da passiva, o valor vai ser um array de tamanho 2, o primeiro é a skill o segundo é contagem dela
	
}

var currentEquipments: Dictionary = { #equipamento de cada digimon
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
	0 : [0.76, 1],
	1 : [1, 1],
	2 : [1, 1]
}
#função init para teste
func loadContent() -> void:
	#teste: gerando grupo de tamanho aleatório aleatório.
	self.addToParty(5) #escolah aleatória do id de um digimon
	#selecionando 3 skills para cada digimon no grupo
	for key: int in self.playerParty:
		if(playerParty[key] != null):
			digimonActiveSkills[key] = SkillDB.getRandomSkills(Util.random(1, 3))
	#teste: gerando equipamentos.
	self.currentEquipments[0].append(ItemDB.getEquipment(2))
	#teste de inventário
	playerInventory.append(ItemDB.getEquipment(1))
	#teste status effect

#Função que adiciona um digimon ao grupo
func addToParty(digimonId: int) -> bool:
	var sucess: bool = false
	for key: int in playerParty:
		if(playerParty[key] == null):
			playerParty[key] = digimonId
			var passiveSkill: PassiveSkill = SkillDB.getNative(digimonId, 0)
			if(self.fixedPassives.has(passiveSkill.skillId)):
				self.fixedPassives[passiveSkill.skillId][1] += 1
			else:
				self.fixedPassives[passiveSkill.skillId] = [SkillDB.getNative(digimonId, 0), 1]
			sucess = true
	return sucess
#função que remove digimon da party
func removeFromParty(index: int) -> void:
	var removedId: int = playerParty[index]
	if(self.fixedPassives.has(removedId)):
		self.fixedPassives[removedId][1] -= 1
		if(self.fixedPassives[removedId][1] <= 0):
			self.fixedPassives.erase(removedId)
	else:
		print("ERROR: No Skill found!")

#função de teste que gera arrays com valores únicos

#função de teste que gera um full set para o Digimon
func getFullSet() -> Array:
	return [ItemDB.getEquipment(Util.pickOne(ItemDB.weapons)), ItemDB.getEquipment(Util.pickOne(ItemDB.offHands)), ItemDB.getEquipment(Util.pickOne(ItemDB.armors)), ItemDB.getEquipment(Util.pickOne(ItemDB.accessories))]
