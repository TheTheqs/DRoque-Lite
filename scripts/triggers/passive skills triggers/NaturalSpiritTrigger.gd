extends Trigger

class_name NaturalSpiritTrigger
#Habilidade passiva nativa do Agumon
var naturePower: NaturalSpirit
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill
	naturePower = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill and context.element == Enums.Element.PLANT):
		digimon.totalDamage *= self.calculateBonusDamage(digimon)
		if!(naturePower.prioritiesChange.has(context)):
			context.bonusPriority += 1
			naturePower.prioritiesChange.append(context)
		return false
	else:
		return false

func calculateBonusDamage(digimon: Digimon) -> float:
	var reference = digimon.tamer.tamerReference
	var team: Array[DigimonData]
	for key in reference.playerParty:
		if(reference.playerParty[key] != null):
			team.append(DDB.getDigimonData(reference.playerParty[key]))
	var plantCount: int = 0
	for digimonData: DigimonData in team:
		if(digimonData.element == Enums.Element.PLANT):
			plantCount += 1
	return (plantCount * 0.08) + 1
