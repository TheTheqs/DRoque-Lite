extends DamageSkill

class_name IceBlast
var skillData: DamageSkillData = load("res://resources/skills/DamageSkills/IceBlast.tres")

func _init():
	setStats(skillData)
	self.isSlow = true
	self.statusEffects.append(AgiMinus.new(Util.random(1, 20)))

func priorityCheck(digimon: Digimon) -> void:
	if(digimon.enemy.getAttribute("agi") > digimon.getAttribute("agi")):
		priority += 1

func applyStats(digimon: Digimon) -> void:
	var newAgiMinus: AgiMinus = self.statusEffects[0].getStatus()
	newAgiMinus.stacks = Util.random(1, 20)
	digimon.applyStatus(newAgiMinus)
