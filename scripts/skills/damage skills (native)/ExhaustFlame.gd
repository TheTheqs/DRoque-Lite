extends DamageSkill

class_name ExhaustFlame
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/ExhaustFlame.tres")

func _init():
	setStats(skillData)
	self.statusEffects.append(Burn.new())

func applyStats(digimon: Digimon) -> void:
	var newBurn: Burn = self.statusEffects[0].getStatus()
	digimon.applyStatus(newBurn)
