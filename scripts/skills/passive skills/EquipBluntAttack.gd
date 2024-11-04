extends PassiveSkill

class_name EquipBluntAttack
var skillData: PassiveSkillData = load("res://resources/skills/passive skills/EquipBluntAttack.tres")

func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	if(learner.digimonSkills[0] != null):
		learner.unlearnSkill(learner.digimonSkills[0])
		learner.digimonSkills[0] = null
	learner.learnSkill(BluntStrike.new())
	return true

func unlearn(learner: Digimon) -> void:
	if(learner.digimonSkills[0] != null):
		learner.unlearnSkill(learner.digimonSkills[0])
		learner.digimonSkills[0] = null
