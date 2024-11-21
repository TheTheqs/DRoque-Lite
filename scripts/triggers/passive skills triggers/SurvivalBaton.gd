extends Trigger

class_name SurvivalBatonTrigger
var effectApplied: bool = false
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is String and context == "BattleStart"):
		self.effectApplied = false
		return false
	elif(context is String and context == "Dying" and digimon.currentHealth <= 0 and self.effectApplied == false and (Util.getValidParty(digimon).size() > 1)):
		self.effectApplied = true
		return true
	else:
		return false
