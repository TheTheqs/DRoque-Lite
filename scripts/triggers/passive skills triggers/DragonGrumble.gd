extends Trigger

class_name DragonGrumbleTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(_digimon: Digimon, context) -> bool:
	if(context is String and context == "BattleStart"):
		return true
	else:
		return false
