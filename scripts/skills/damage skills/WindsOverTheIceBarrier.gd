extends DamageSkill

class_name WindsOverTheIceBarrier
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/WindsOverTheIceBarrier.tres")

func _init():
	setStats(skillData)
	self.statusEffects.append(Freeze.new())

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.enemy.tamer.actions > 1):
		priority += 2

func applyStats(digimon: Digimon) -> void:
	var newFreeze: Freeze = self.statusEffects[0].getStatus()
	digimon.applyStatus(newFreeze)
