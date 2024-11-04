extends Trigger

class_name SupplySquadTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
var bonusGranted: bool = false
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(bonusGranted == false and context is ItemUser and context.relatedItem is UsableItem and Util.getProportion(digimon.currentHealth, digimon.maxHelth) <= 0.15):
		bonusGranted = true
		return true
	elif(context is String and context == "BattleStart"):
		bonusGranted = false
		return false
	else:
		return false
