extends Trigger

class_name EfficientCastingTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is float and context > 1 and Util.getProportion(digimon.currentMana, digimon.maxMana) >= 0.7):
		digimon.consumedMana = Util.cap(digimon.consumedMana/2)
		digimon.skillAnnouncer.announceSkill(action.skillIcon)
		return false
	else:
		return false
