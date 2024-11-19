extends DamageSkill

class_name FangStrike
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/StrikeFang.tres")

func _init():
	setStats(skillData)
	self.isSlow = true
	self.statusEffects.append(Stun.new())

func applyStats(digimon: Digimon) -> void:
	var newStun: Stun = self.statusEffects[0].getStatus()
	digimon.applyStatus(newStun)
