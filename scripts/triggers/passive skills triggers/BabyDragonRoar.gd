extends Trigger

class_name BabyDragonRoarTrigger
#Habilidade passiva nativa do Agumon
var babyDragon: BabyDragonRoar
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill
	babyDragon = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill and context.element == Enums.Element.FIRE):
		digimon.totalDamage *= 1.15
		if!(babyDragon.prioritiesChange.has(context)):
			context.bonusPriority += 1
			babyDragon.prioritiesChange.append(context)
		return false
	else:
		return false
