extends Trigger

class_name CounterMagicTrigger
var controlVar: bool = false
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(_digimon: Digimon, context) -> bool:
	if(context is StatusEffect and context.statusType == Enums.StatusType.DEBUFF and !controlVar):
		controlVar = true
		action.currentStatus = context
		return true
	elif(context is String and context == "TurnStart"):
		controlVar = false
		return false
	else:
		return false
