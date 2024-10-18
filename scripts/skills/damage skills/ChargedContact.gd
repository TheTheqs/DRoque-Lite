extends DamageSkill

class_name ChargedContact
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/ChargedContact.tres")
var damageBonus: float = 1.0

func _init():
	setStats(skillData)

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.THUNDER):
		priority += 2

#Função sobreescrita, que vai aumentar o dano causado quando o digimon for do tipo trovão
func setValues(digimon: Digimon) -> void:
	self.atackerType = digimon.digimonType
	self.damageValue = digimon.getSkillDamage(self)
	self.damageValue *= ratio
	self.damageValue *= damageBonus
	self.accuracy = digimon.getAccuracy(self, digimon.enemy)
	self.isCritic = Util.chance(digimon.getCriticalChance())
	if(self.isCritic):
		self.damageValue *= 1.5
	skillSingularity(digimon)

func skillSingularity(digimon: Digimon) -> void:
	if(damageBonus < 2.5 and digimon.element == Enums.Element.THUNDER):
		damageBonus += 0.5
