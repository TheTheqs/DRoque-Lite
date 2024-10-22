extends Trigger

class_name SlowAntibodiesTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
var bonusGranted: bool = false
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is String and context == "PassingTurn" and digimon.statusEffect.has(0) and bonusGranted == false):
		bonusGranted = true
		return true
	elif(context is String and context == "BattleStart"):
		bonusGranted = false
		return false
	else:
		return false
