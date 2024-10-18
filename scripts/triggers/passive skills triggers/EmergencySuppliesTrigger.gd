extends Trigger

class_name EmergencySuppliesTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
#triggers de passivas nunca ativam o efeito em checkContext, diferente de triggers de efeitos.
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context == "BattleStart" and (Util.getProportion(digimon.currentHealth, digimon.maxHelth) <= 0.5)):
		return true
	else:
		return false
