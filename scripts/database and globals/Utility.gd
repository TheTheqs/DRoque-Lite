extends Node

class_name Utility

#Get a random number
func random(minn: int, maxn: int) -> int:
	return randi_range(minn, maxn)

#retorna true ou false baseado em uma chance
func chance(nchance: float) -> bool:
	if (nchance >= 100):
		return true
	var randomValue = randf() * 100
	return randomValue <= chance
#função que capa números float, para que eles tenham apenas 2 casa decimais
func cap(value: float) -> float:
	return round(value*100)/100

#cria um damage data baseado em uma skill
func damageDataBuilder(damageSkill: DamageSkill) -> DamageData:
	var newDamageData : DamageData = DamageData.new()
	newDamageData.buildData(damageSkill.damageType, damageSkill.element, damageSkill.atackerType, damageSkill.damageValue, damageSkill.isCritic)
	return newDamageData

func getProportion(portion: float, whole: float) -> float:
	return portion/whole
