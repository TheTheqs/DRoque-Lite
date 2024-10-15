extends DamageSkill

class_name DoubleDelta
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/DoubleDelta.tres")

func _init():
	setStats(skillData)

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.WATER):
		priority += 2

#Função sobreescrita, que sempre resulta crítico em digimons do tipo água (esse é o efeito da habilidade).
func setValues(digimon: Digimon) -> void:
	self.atackerType = digimon.digimonType
	self.damageValue = digimon.getSkillDamage(self.damageType)
	self.damageValue *= ratio
	self.accuracy = digimon.getAccuracy()
	if(digimon.element == Enums.Element.WATER):
		self.isCritic = true
	else:
		self.isCritic = Util.chance(digimon.getCriticalChance())
	if(self.isCritic):
		self.damageValue *= 1.5
	skillSingularity(digimon)
