extends Trigger

class_name DisarmTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init() -> void:
	self.triggerId = 36

func checkContext(_digimon: Digimon, context) -> bool:
	if(context is ItemUser and context.relatedItem is Equipment and context.relatedItem.equipType == Enums.EquipmentType.WEAPON):
		context.relatedItem.canUse = false
		return false
	else:
		return false
