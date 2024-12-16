extends ItemEffect
#item que promove a fusão entre digimons
class_name UniqueDNAEffect
#dicionário para determinar nível mínimo
var levelDic: Dictionary = {
	Enums.Tier.ROOKIE : 15,
	Enums.Tier.CHAMPION : 40,
	Enums.Tier.ULTIMATE : 70,
	Enums.Tier.MEGA : 80
}
var minLevel : int
var possibleMaterials: Array[int] = []
var finalDigimonID: int

func itemEffect(digimon: Digimon) -> void:
	if(self.checkFusion(digimon)):
		if(self.possibleMaterials.size() == 1):
			self.finalDigimonID = digimon.digimonFusions[self.possibleMaterials[0]]
			var materialIndex: int
			for key: int in digimon.tamer.tamerReference.playerParty:
				if(self.possibleMaterials[0] == digimon.tamer.tamerReference.playerParty[key]):
					materialIndex = key
			digimon.globalEffects.setFusion(DDB.getDigimonData(self.possibleMaterials[0]).texture)
			digimon.tamer.tamerReference.removeFromParty(materialIndex)
			self.managePassive(self.possibleMaterials[0], digimon)
			digimon.Evolve(self.finalDigimonID)
			if(digimon.tamer is Enemy):
				digimon.tamer.actions += 1
	else:
		digimon.tamer.showContent(tr(StringName("Fail")))

func priorityCalc(_digimon: Digimon) -> int:
	return 0

func checkFusion(digimon: Digimon) -> bool:
	self.possibleMaterials = []
	if(digimon.digimonFusions.size() < 1):
		return false
	self.minLevel = self.levelDic[digimon.digimonTier]
	if(digimon.currentLevel < self.minLevel):
		return false
	var digimonsInParty: Array[int] = digimon.tamer.tamerReference.partyMembers
	for key: int in digimon.digimonFusions:
		if(digimonsInParty.has(key)):
			self.possibleMaterials.append(key)
	if(self.possibleMaterials.size() < 1):
		return false
	return true

func managePassive(digimonId: int, digimon: Digimon) -> void:
	var passiveSkill: PassiveSkill = SkillDB.getNative(digimonId, 0)
	if(digimon.tamer.tamerReference.fixedPassives.has(passiveSkill.skillId)):
		return
	else:
		digimon.unlearnSkill(passiveSkill)
