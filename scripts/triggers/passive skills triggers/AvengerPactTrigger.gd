extends Trigger

class_name AvengerPactTrigger
#Habilidade passiva nativa do Agumon
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is String and context == "Changing"):
		var chance: int = digimon.tamer.tamerReference.partyMembers.size()*5
		chance = min(15, chance)
		if(Util.chance(chance)):
			return true
		else:
			return false
	else:
		return false
