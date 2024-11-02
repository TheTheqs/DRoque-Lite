extends ItemEffect

class_name RedPotionEffect

func itemEffect(digimon: Digimon) -> void:
	digimon.heal(Util.cap(digimon.maxHelth*0.5), false)

func priorityCalc(digimon: Digimon) -> int:
	var priority: int = 0
	var healthProp: float = Util.getProportion(digimon.currentHealth, digimon.maxHelth) * 100.0
	var thresholds = [80, 60, 40, 20]
	var increments = [1, 1, 1, 2]
	for i in range(thresholds.size()):
		if healthProp <= thresholds[i]:
			priority += increments[i]
	if(healthProp > 80):
		priority = 0
	return priority
