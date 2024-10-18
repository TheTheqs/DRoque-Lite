extends DamageSkill

class_name OpressTheWeak
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/OpressTheWeak.tres")

func _init():
	setStats(skillData)
	self.statusEffects.append(Exhaust.new())
func priorityCheck(digimon: Digimon) -> void:
	if(Util.getProportion(digimon.enemy.currentHealth, digimon.enemy.maxHelth) <= 0.5):
		priority += 4

func applyStats(digimon: Digimon) -> void:
	if(Util.getProportion(digimon.currentHealth, digimon.maxHelth) <= 0.4):
		var newExhaust: Exhaust = self.statusEffects[0].getStatus()
		newExhaust.schance = -1
		digimon.applyStatus(newExhaust)
