extends DamageSkill

class_name FieryFlicker
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/FieryFlicker.tres")
var oldManaCost: int = 0
func _init():
	setStats(skillData)

#classe de aprendizado sobreescrita para atender os efeitos da habilidade
func learn(learner: Digimon, index: int) -> bool:
	learner.digimonSkills[index] = self
	if(learner.element == Enums.Element.FIRE):
		oldManaCost = manaCost
		manaCost = 0
	return true

func unlearn(_unlearner: Digimon) -> void:
	manaCost = oldManaCost
	oldManaCost = 0

#prioridade para digimons do tipo fogo por conta do seu efeito.
func priorityCheck(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.FIRE):
		priority += 2

#singularidade da habilidade
func skillSingularity(digimon: Digimon) -> void:
	if(digimon.element == Enums.Element.FIRE):
		digimon.heal(float(oldManaCost), true)
