extends PassiveSkill

class_name SurvivalBaton
var skillData: PassiveSkillData = load("res://resources/skills/passive skills/SurvivalBaton.tres")
func _init():
	setStats(skillData)

func learn(learner: Digimon, _index: int) -> bool:
	learner.onBattleStart.append(self.skillTriggers[0])
	learner.onDying.append(self.skillTriggers[0])
	return true

func unlearn(learner: Digimon) -> void:
	learner.onBattleStart.erase(self.skillTriggers[0])
	learner.onDying.erase(self.skillTriggers[0])

func skillSingularity(digimon: Digimon) -> void:
	digimon.heal(Util.cap(digimon.maxHelth*0.20), false)
	var playerParty: Array = Util.getValidParty(digimon)
	playerParty.erase(digimon.tamer.tamerReference.playerCurrentChoice)
	var newerChoice: int = Util.pickOne(playerParty)
	digimon.tamer.changeDigimon(newerChoice)
