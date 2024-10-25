extends DamageSkill

class_name OpressTheWeak
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/OpressTheWeak.tres")

func _init():
	setStats(skillData)
	self.statusEffects.append(Exhaust.new())

func applyStats(digimon: Digimon) -> void:
	var newExhaust: Exhaust = self.statusEffects[0].getStatus()
	digimon.applyStatus(newExhaust)
