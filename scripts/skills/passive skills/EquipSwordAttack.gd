extends PassiveSkill

class_name EquipSwordAttack
var skillData: PassiveSkillData = load("res://resources/skills/passive skills/EquipSwordAttack.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	if(learner.digimonSkills[0] != null):
		learner.unlearnSkill(learner.digimonSkills[0])
		learner.digimonSkills[0] = null
	learner.learnSkill(SwordAtack.new())
	return true

func unlearn(learner: Digimon) -> void:
	if(learner.digimonSkills[0] != null):
		learner.unlearnSkill(learner.digimonSkills[0])
		learner.digimonSkills[0] = null
