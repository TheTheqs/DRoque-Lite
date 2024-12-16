extends Trigger

class_name BackwaterCampTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageData):
		context.damageValue *= 1.2
	elif(context is Skill):
		digimon.totalDamage *= 1.2
	return false
