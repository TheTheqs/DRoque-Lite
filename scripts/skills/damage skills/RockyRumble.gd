extends DamageSkill

class_name RockyRumble
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/RockyRumble.tres")

func _init():
	setStats(skillData)

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.EARTH):
		priority += 2

#Função sobreescrita, que sempre resulta em acerto, se usada por um monstro do tipo terra.
func setValues(digimon: Digimon) -> void:
	self.atackerType = digimon.digimonType
	self.damageValue = digimon.getSkillDamage(self.damageType)
	self.damageValue *= ratio
	if(digimon.element == Enums.Element.EARTH):
		self.accuracy = -1
	else:
		self.accuracy = digimon.getAccuracy(self, digimon.enemy)
	self.isCritic = Util.chance(digimon.getCriticalChance())
	if(self.isCritic):
		self.damageValue *= 1.5
	skillSingularity(digimon)
