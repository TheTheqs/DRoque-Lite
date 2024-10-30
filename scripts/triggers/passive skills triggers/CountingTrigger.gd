extends Trigger

class_name CoutingTrigger
var count: int = 0
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is String and context == "TurnStart" and count < digimon.currentLevel):
		count += 1
		return true
	if(context is String and context == "BattleStart"):
		count = 0
		return false
	else:
		return false
