extends Trigger

class_name MarkingDodgeTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado

func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(_digimon: Digimon, context) -> bool:
	if(context is DamageSkill and context.damageSubType == Enums.DamageSubType.DIRECT):
		return true
	else:
		return false
