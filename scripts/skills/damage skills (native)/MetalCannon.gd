extends DamageSkill

class_name MetalCannon
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/MetalCannon.tres")

func _init():
	setStats(skillData)
	self.statusEffects.append(Disarm.new(1))

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.enemy.armory[0] != null):
		priority += 2

func applyStats(digimon: Digimon) -> void:
	var newDisarm: Disarm = self.statusEffects[0].getStatus()
	digimon.applyStatus(newDisarm)
