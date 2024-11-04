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
	0 : [BasicAtack.new()], #esses arrays precisam ter de prefencia size fixo em 5
	1 : [BasicAtack.new()],
	2 : [BasicAtack.new()],
}
var fixedPassives: Dictionary = { #Habilidades passivas de cada digimon
	0 : [],
	1 : [],
	2 : []
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

var currentHealth: Dictionary = { #proporção da vida de cada digimon 
	0 : 0.67,
	1 : 0.33,
	2 : 1.0
}
#função init para teste
func loadContent() -> void:
	#pegando ids aleatórios do banco de dados para preencher a party
	playerParty[0] = Util.random(0, 5)
	playerParty[1] = Util.random(0, 5)
	playerParty[2] = Util.random(0, 5)
	#completando as skills ativas com 4 skills adicionais para cada digimon
	var activeSkillsID: Array = SkillDB.activeSkillsID
	for skillId: int in generateUniqueArray(activeSkillsID):
		digimonActiveSkills[0].append(SkillDB.getSkill(skillId))
	for skillId: int in generateUniqueArray(activeSkillsID):
		digimonActiveSkills[1].append(SkillDB.getSkill(skillId))
	for skillId: int in generateUniqueArray(activeSkillsID):
		digimonActiveSkills[2].append(SkillDB.getSkill(skillId))
	#pegando 4 skills passivas para cada digimon
	var passiveIDS: Array = SkillDB.passiveSkillsID
	for skillId: int in generateUniqueArray(passiveIDS):
		fixedPassives[0].append(SkillDB.getSkill(skillId))
	for skillId: int in generateUniqueArray(passiveIDS):
		fixedPassives[1].append(SkillDB.getSkill(skillId))
	for skillId: int in generateUniqueArray(passiveIDS):
		fixedPassives[2].append(SkillDB.getSkill(skillId))
	#escolha de equipamentos
	currentEquipments[0] = getFullSet()
	currentEquipments[1] = getFullSet()
	currentEquipments[2] = getFullSet()
	#teste de inventário
	playerInventory.append(ItemDB.getUsableItem(0))
	playerInventory.append(ItemDB.getUsableItem(0))
	playerInventory.append(ItemDB.getUsableItem(0))
	playerInventory.append(ItemDB.getEquipment(3))
	playerInventory.append(ItemDB.getEquipment(5))
	playerInventory.append(ItemDB.getEquipment(2))
	playerInventory.append(ItemDB.getEquipment(1))

#função de teste que gera arrays com valores únicos
func generateUniqueArray(sourcePick: Array) -> Array:
	var selectedIds: Array[int] = []
	var id1: int = Util.pickOne(sourcePick)
	selectedIds.append(id1)
	var id2: int = Util.pickOne(sourcePick)
	while(id2 in selectedIds):
		id2 = Util.pickOne(sourcePick)
	selectedIds.append(id2)
	var id3: int = Util.pickOne(sourcePick)
	while(id3 in selectedIds):
		id3 = Util.pickOne(sourcePick)
	selectedIds.append(id3)
	var id4: int = Util.pickOne(sourcePick)
	while(id4 in selectedIds):
		id4 = Util.pickOne(sourcePick)
	selectedIds.append(id4)
	return selectedIds
#função de teste que gera um full set para o Digimon
func getFullSet() -> Array:
	return [ItemDB.getEquipment(Util.pickOne(ItemDB.weapons)), ItemDB.getEquipment(Util.pickOne(ItemDB.offHands)), ItemDB.getEquipment(Util.pickOne(ItemDB.armors)), ItemDB.getEquipment(Util.pickOne(ItemDB.accessories))]
