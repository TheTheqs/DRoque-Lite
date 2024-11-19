extends DamageSkill

class_name PowerMetal
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/PowerMetal.tres")

func _init():
	setStats(skillData)
	self.isSlow = true
	self.statusEffects.append(Disarm.new(1))

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.enemy.armory[0] != null):
		priority += 4

func applyStats(digimon: Digimon) -> void:
	var newDisarm: Disarm = self.statusEffects[0].getStatus()
	newDisarm.schance = -1
	digimon.applyStatus(newDisarm)
