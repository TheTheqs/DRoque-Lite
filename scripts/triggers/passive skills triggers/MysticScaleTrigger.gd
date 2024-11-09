extends Trigger

class_name MysticScaleTrigger
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
var bonusGranted: bool = false
var blockedStatus: Array[int] = [43, 45, 47, 49, 51, 53]
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(bonusGranted == false and context is StatusEffect and blockedStatus.has(context.statusId)):
		bonusGranted = true
		context.schance = 0
		digimon.skillAnnouncer.announceSkill(action.skillIcon)
		return false
	elif(context is String and context == "BattleStart"):
		bonusGranted = false
		return true
	else:
		return false
