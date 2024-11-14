extends Trigger

class_name DragonRoarTrigger
#Habilidade passiva nativa do Agumon
var dragon: DragonRoar
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill
	dragon = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill and context.element == Enums.Element.FIRE):
		digimon.totalDamage *= 1.30
		if!(dragon.prioritiesChange.has(context)):
			context.bonusPriority += 2
			dragon.prioritiesChange.append(context)
		return false
	else:
		return false
