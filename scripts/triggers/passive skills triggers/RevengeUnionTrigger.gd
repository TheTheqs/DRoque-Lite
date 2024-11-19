extends Trigger

class_name RevengeUnionTrigger
#Habilidade passiva nativa do Agumon
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is String and context == "Changing"):
		var chance: int = digimon.tamer.tamerReference.partySize*10
		chance = min(30, chance)
		if(Util.chance(chance)):
			return true
		else:
			return false
	else:
		return false
