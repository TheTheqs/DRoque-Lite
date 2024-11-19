extends DamageSkill

class_name StickyNet
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/StickyNet.tres")

func _init():
	setStats(skillData)
	self.isSlow = true
	self.statusEffects.append(AgiMinus.new(15))

func applyStats(digimon: Digimon) -> void:
	var newAgiM: AgiMinus = self.statusEffects[0].getStatus()
	digimon.applyStatus(newAgiM)

#Implementar o cálculo deAGI -, pois o valor é dinâmico mas o atual é puramnente para depuração
