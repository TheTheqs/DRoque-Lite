extends DamageSkill

class_name ThornyThrust
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/ThornyThrust.tres")
var oldCDR: int = 0
func _init():
	setStats(skillData)

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.PLANT):
		priority += 2

#Função sobreescrita, que dobra o dano quando o digimon que sua for do tipo planta.
func setValues(digimon: Digimon) -> void:
	self.atackerType = digimon.digimonType
	self.damageValue = digimon.getSkillDamage(self)
	self.damageValue *= ratio
	self.accuracy = digimon.getAccuracy(self, digimon.enemy)
	if(digimon.element == Enums.Element.PLANT):
		self.damageValue *= 2
	self.isCritic = Util.chance(digimon.getCriticalChance(self))
	if(self.isCritic):
		self.damageValue *= 1.5
	skillSingularity(digimon)

#funções de aprendizado que dobram o tempo de recarga quando o digimon for do tipo planta.
func learn(learner: Digimon, index: int) -> bool:
	learner.digimonSkills[index] = self
	oldCDR = cooldowm
	if(learner.element == Enums.Element.PLANT):
		cooldowm *= 2
		print(str(cooldowm))
	return true

func unlearn(_unlearner: Digimon) -> void:
	cooldowm = oldCDR
	oldCDR = 0
	print(str(cooldowm))
