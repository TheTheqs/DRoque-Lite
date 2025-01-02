extends Trigger

class_name ResistTrigger
#preencher com atributos de identificação
func _init() -> void:
	self.triggerId = 13

func checkContext(_digimon: Digimon, context) -> bool:
	if(context is StatusEffect and context.statusType == Enums.StatusType.DEBUFF and context.schance > 0):
		context.schance *= 0.75
	return false
