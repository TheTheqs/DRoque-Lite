extends DamageSkill

class_name StickyNet
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/StickyNet.tres")
var stickyNetTrigger: StickyNetTrigger = StickyNetTrigger.new()
func _init():
	setStats(skillData)
	self.isSlow = true

func learn(learner: Digimon, index: int) -> bool:
	learner.digimonSkills[index] = self
	learner.onDamageDelt.append(stickyNetTrigger)
	return true

func unlearn(unlearner: Digimon) -> void:
	unlearner.onDamageDelt.erase(stickyNetTrigger)
	pass

#Implementar o cálculo deAGI -, pois o valor é dinâmico mas o atual é puramnente para depuração
