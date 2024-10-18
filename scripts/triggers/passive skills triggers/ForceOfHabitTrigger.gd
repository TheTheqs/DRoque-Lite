extends Trigger

class_name ForceOfHabitTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill):
		if(context.skillId in digimon.digimonLearnedSkills):
			context.damageValue /= 2
			digimon.skillAnnouncer.announceSkill(action.skillIcon)
	return false
