extends Trigger

class_name KeenTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill):
		digimon.criticalChance += 1.15
		return false
	else:
		return false
