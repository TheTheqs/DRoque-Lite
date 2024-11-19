extends Trigger

class_name VeemonECT
var relatedEC: EvolutionChart

func _init(newEC: EvolutionChart) -> void:
	self.relatedEC = newEC

func checkContext(digimon: Digimon, context) -> bool:
	if(digimon.currentLevel >= 15 and (digimon.getAttribute("str") > digimon.getAttribute("wis")) and context is DamageData and context.damageElement == Enums.Element.LIGHT and (Util.getProportion(digimon.enemy.currentHealth, digimon.enemy.maxHelth) < 0.5)):
		relatedEC.activateEvolution(0)
	return false
