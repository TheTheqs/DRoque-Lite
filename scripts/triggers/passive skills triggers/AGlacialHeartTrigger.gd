extends Trigger

class_name AGlacialHeartTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is StatusEffect and context.statusId == 6):
		digimon.heal(Util.cap(digimon.maxHelth*0.2), false)
		digimon.skillAnnouncer.announceSkill(action.skillIcon)
		return false
	elif(context is int and context == 6):
		return true
	else:
		return false
