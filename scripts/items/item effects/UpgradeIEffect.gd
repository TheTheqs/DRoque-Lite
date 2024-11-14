extends ItemEffect

class_name UpgradeIEffect

func itemEffect(digimon: Digimon) -> void:
	if(Util.checkArray(digimon.possibleEvolution) and digimon.digimonTier == Enums.Tier.ROOKIE and digimon.currentLevel >= 15):
		digimon.Evolve(digimon.possibleEvolution[0])
	else:
		digimon.tamer.showContent(tr(StringName("Fail")))

func priorityCalc(digimon: Digimon) -> int:
	var priority: int = 0
	var priorityDic: Dictionary = {
		0 : 0,
		1 : 3,
		2 : 5,
		3 : 7
	}
	priority += priorityDic[digimon.enemy.digimonTier]
	return priority
